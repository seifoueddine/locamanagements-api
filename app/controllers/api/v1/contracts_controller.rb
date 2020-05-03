class Api::V1::ContractsController < ApplicationController
  before_action :set_contract, only: %i[show update destroy]

  # GET /contracts
  def index
    @contracts = Contract.all

    render json: @contracts
  end

  # GET /contracts/1
  def show
    render json: @contract
  end

  # POST /contracts
  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      render json: @contract, status: :created, location: @contract
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
    @contract.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contract
    @contract = Contract.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def contract_params
    params.require(:contract).permit(:contract_type, :contract_details,
                                     :payment_frequency_number, :payment_frequency_name,
                                     :payment_date, :start_date, :end_date, :property_id,
                                     :user_id, :contact_id, :slug_id)
  end
end
