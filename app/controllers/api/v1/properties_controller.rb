class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property, only: %i[show update]
  # GET /properties
  def index
    slug_id = get_slug_id
    params[:slug_id] = slug_id
    transactionTypeArray = %w[sell rent]
    propertyTypeArray = %w[1 2]
    greaterThan = 0
    lessThan = 999999999
    @properties = if params[:search].blank? && params[:transactionType].blank? && params[:propertyType].blank? && params[:greaterThan].blank? && params[:lessThan].blank?
                    Property.order(order_and_direction).page(page).per(per_page)
                  elsif params[:search].blank?

                    unless params[:transactionType].blank?
                      transactionTypeArray = params[:transactionType].split(',')
                    end

                    unless params[:propertyType].blank?
                      propertyTypeArray = params[:propertyType].split(',')
                    end

                    unless params[:greaterThan].blank?
                      greaterThan = params[:greaterThan].to_i
                    end

                    unless params[:lessThan].blank?
                      lessThan = params[:lessThan].to_i
                    end


                    transactionTypeParams = transactionTypeArray.length > 1 ? transactionTypeArray : params[:transactionType]
                    propertyTypeParams =  propertyTypeArray.length > 1 ? propertyTypeArray : params[:propertyType]
                    Property.joins(:contact).order(order_and_direction)
                            .page(page).per(per_page)
                            .where(transaction_type: transactionTypeParams, property_type: propertyTypeParams,
                                   agency_price: greaterThan..lessThan)

                  else
                    Property.joins(:contact).order(order_and_direction)
                            .page(page).per(per_page)
                            .where(['lower(label) like ?
                                     or lower(contacts.name) like ?',
                                     '%' + params[:search].downcase + '%',
                                     '%' + params[:search].downcase + '%',
                                   ])

                  end

    set_pagination_headers :properties
    json_string = PropertySerializer.new(@properties, include: [:contact])
                                    .serialized_json
    render json: json_string

  end

  # GET /properties/1
  def show
    json_string = PropertySerializer.new(@property, include: [:contact])
                                    .serialized_json
    render json: json_string
  end

  # POST /properties
  def create
    slug_id = get_slug_id
    params[:slug_id] = slug_id
    @property = Property.new(property_params)

    if @property.save!
      render json: @property, status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /properties/1
  def update
    if @property.update(property_params)
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # DELETE /properties/1
  def destroy
    ids = params[:id].split(',')
    if ids.length != 1
      Property.where(id: params[:id].split(',')).destroy_all
    else
      Property.find(params[:id]).destroy
    end

  rescue ActiveRecord::InvalidForeignKey => e
    render json: {
        code:  'E001',
        message: 'This property has a contract'
    },  status: 406
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def property_params
    params.permit(:label, :contact_id, :slug_id, { images: [] }, :property_type,
                  :surface, :address, :wilaya, :city, :owner_price,
                  :agency_price, :transaction_type, :nbr_of_pieces,
                  :is_furnished, :is_equipped, :has_elevator, :has_floors,
                  :floor, :has_garage, :has_garden, :has_swimming_pool,
                  :has_sanitary, :description)
  end
end
