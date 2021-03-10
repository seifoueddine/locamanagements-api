class Api::V1::ContractsController < ApplicationController
  before_action :set_contract, only: %i[show update]

  # GET /contracts
  def index
    slug_id = get_slug_id
    params[:slug_id] = slug_id
    @contracts = if params[:slug_id].blank?
                   Contract.order(order_and_direction).page(page).per(per_page)
                 elsif params[:search].blank?
                   Contract.order(order_and_direction).page(page).per(per_page)
                           .where(slug_id: slug_id)
                 else

                 Contract.order(order_and_direction).page(page).per(per_page)
                         .where(slug_id: slug_id)
                         .where(['lower(contract_type) like ?
                            or lower(contract_details) like ?',
                           '%' + params[:search].downcase + '%',
                           '%' + params[:search].downcase + '%',
                          ])
                 end
    set_pagination_headers :contracts
    json_string = ContractSerializer.new(@contracts, include: %i[contact properties]).serialized_json
    render  json: json_string
  end

  # GET /contracts/1
  def show
    json_string = ContractSerializer.new(@contract, include: %i[contact properties])
                                    .serialized_json
    render json: json_string
  end

  # POST /contracts
  def create
    slug_id = get_slug_id
    params[:slug_id] = slug_id
    @contract = Contract.new(contract_params)
    @contract.payment_periods = params[:payment_periods]

    if @contract.save
      @property = Property.find_by_id(@contract.property_id)
      @property.contract_id = @contract.id
      @property.save!
      render json: @contract, status: :created
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contracts/1
  def update
    unless params[:payment_periods].blank?
      @contract.payment_periods = params[:payment_periods]
    end
    if @contract.update(contract_params)
      json_string = ContractSerializer.new(@contract, include: %i[contact properties])
                                      .serialized_json
      render json: json_string
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contracts/1
  def destroy
    ids = params[:id].split(',')
    if ids.length != 1
      @contracts_to_delete =  Contract.where(id: params[:id].split(','))
      @contracts_to_delete.map do |contract|
        @property = Property.find_by_id(contract.property_id)
        @property.contract_id = nil
        @property.save!
      end
      @contracts_to_delete.destroy_all
    else
      @contract = Contract.find_by_id(params[:id])
      property_id = @contract.property_id
      @property = Property.find_by_id(property_id)
      @property.contract_id = nil
      @property.save!
      @contract.destroy
      unless @contract.destroyed?
        @property = Property.find_by_id(@contract.property_id)
        @property.contract_id = @contract.id
        @property.save!
      end

    end

  end


  # export PDF
  def pdf_export
    id = params[:id]
    index = params[:index]
    @index_period = index.to_i + 1
    @contract = Contract.find(id)
    @period = @contract.payment_periods[index.to_i]
    puts @period
    slug_id = get_slug_id
    @slug = Slug.find(slug_id)
    @html = get_html
    pdf = WickedPdf.new.pdf_from_string(@html)
    send_data pdf, filename: 'Payment_' + @contract.id.to_s + '.pdf', status: :created , type: 'application/pdf'
  end

  def get_html
    '<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <style>
      div.alwaysbreak { page-break-before: always; }
div.nobreak:before { clear:both; }
div.nobreak { page-break-inside: avoid; }
    </style>
  </head>
  <body>

  <div leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" offset="0"
      style="height:auto !important;width:100% !important; font-family: Helvetica,Arial,sans-serif !important; margin-bottom: 40px;">
      <div class="justify-content-center d-flex">
        <table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0"
          style="max-width:600px; background-color:#ffffff;border:1px solid #e4e2e2;border-collapse:separate !important; border-radius:10px;border-spacing:0;color:#242128; margin:0;padding:40px;"
          heigth="auto">
          <tbody>
            <tr>
              <td align="left" valign="center"
                style="padding-bottom:40px;border-top:0;height:100% !important;width:100% !important;">
                <img style="height: 45px;" src="http://localhost:3000'  + @slug.logo.url + '  "  />
              </td>
              <td align="right" valign="center"
                style="padding-bottom:40px;border-top:0;height:100% !important;width:100% !important;">
                <span style="color: #8f8f8f; font-weight: normal; line-height: 2; font-size: 14px;">02.02.2019</span>
              </td>
            </tr>
            <tr>
              <td colSpan="2" style="padding-top:10px;border-top:1px solid #e4e2e2">
                <h3 style="color:#303030; font-size:18px; line-height: 1.6; font-weight:500;">Get Started</h3>
                <p style="color:#8f8f8f; font-size: 14px; padding-bottom: 20px; line-height: 1.4;">
                  Dynamically target high-payoff intellectual capital for customized technologies. Objectively integrate
                  emerging core competencies before process-centric communities. Dramatically evisculate holistic
                  innovation rather than client-centric data.<br /><br />Progressively maintain extensive infomediaries
                  via extensible niches. Dramatically disseminate standardized metrics after resource-leveling
                  processes.
                </p>
                <h3 style="color:#303030; font-size:18px; line-height: 1.6; font-weight:500;">Paiment de la periode ' + @index_period.to_s + '</h3>
                <p
                  style="background-color:#f1f1f1; padding: 8px 15px; border-radius: 50px; display: inline-block; margin-bottom:20px; font-size: 14px;  line-height: 1.4; font-family: Courier New, Courier, monospace; margin-top:0">
                  '+ @period['periode_price'].to_s + ' DZD</p>
                <h3 style="color:#303030; font-size:18px; line-height: 1.6; font-weight:500;">Steps to Follow</h3>
                <ol style="color:#8f8f8f; font-size: 14px; padding-bottom: 20px; padding-left:20px; line-height: 1.6">
                  <li>Preliminary thinking systems</li>
                  <li>Bandwidth efficient</li>
                  <li>Green space</li>
                  <li>Social impact</li>
                </ol>
              </td>
            </tr>
            <tr>
              <td colSpan="2">
                <table border="0" cellpadding="0" cellspacing="0" width="100%"
                  style="min-width:100%;border-collapse:collapse;">
                  <tbody>
                    <tr>
                      <td style="padding:15px 0px;" valign="top" align="center">
                        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate !important;">
                          <tbody>
                            <tr>
                              <td align="center" valign="middle" style="padding:13px;">
                                <a href="#" title="START NOW" target="_blank"
                                  style="font-size: 14px; line-height: 1.5; font-weight: 700; letter-spacing: 1px; padding: 15px 40px; text-align:center; text-decoration:none; color:#FFFFFF; border-radius: 50px; background-color:#00365a;">START
                                  NOW</a>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="justify-content-center d-flex">
        <table style="margin-top:30px; padding-bottom:20px;; margin-bottom: 40px;">
          <tbody>
            <tr>
              <td align="center" valign="center">
                <p
                  style="font-size: 12px; text-decoration: none;line-height: 1; color:#909090; margin-top:0px; margin-bottom:5px; ">
                  ColoredStrategies Inc, 35 Little Russell St. Bloomsburg London,UK
                </p>
                <p style="font-size: 12px; line-height:1; color:#909090;  margin-top:5px; margin-bottom:5px;">
                  <a href="#" style="color: #00365a; text-decoration:none;">Privacy Policy</a> | <a href="#"
                    style="color: #00365a; text-decoration:none;">Unscubscribe</a>
                </p>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>




  </body>
</html>'
  end




  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contract
    @contract = Contract.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def contract_params
    params.permit(:contract_type, :contract_details,
                         :payment_frequency_number, :payment_frequency_name,
                         :payment_date, :start_date, :end_date, :property_id,
                         :user_id, :contact_id, :slug_id, :payment_periods)
  end
end
