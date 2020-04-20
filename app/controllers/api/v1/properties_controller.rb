class Api::V1::PropertiesController < ApplicationController
  before_action :set_property, only: %i[show update]

  # GET /properties
  def index

    if params[:search].blank?
      @properties = Property.order(order_and_direction).page(page).per(per_page)
    else
      @properties = Property.joins(:contact).order(order_and_direction)
                            .page(page).per(per_page)
                            .where(['lower(label) like ?
                                     or lower(contacts.name) like ? ',
                                    '%' + params[:search].downcase + '%',
                                    '%' + params[:search].downcase + '%'])
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
        code: 'E001',
        message: 'This contact has a property'
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
