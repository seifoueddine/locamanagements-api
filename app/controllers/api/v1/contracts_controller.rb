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
    render json: @contract
  end

  # POST /contracts
  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      render json: @contract, status: :created
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contracts/1
  def update
    if @contract.update(contract_params)
      render json: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contracts/1
  def destroy
    ids = params[:id].split(',')
    if ids.length != 1
      Contract.where(id: params[:id].split(',')).destroy_all
    else
      Contract.find(params[:id]).destroy
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
                         :user_id, :contact_id, :slug_id)
  end
end
