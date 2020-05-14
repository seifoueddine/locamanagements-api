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
