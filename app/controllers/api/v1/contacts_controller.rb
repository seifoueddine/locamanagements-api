class Api::V1::ContactsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_contact, only: %i[show update]

  # GET /contacts
  def index
    if params[:search].blank?
      @contacts = Contact.order(order_and_direction).page(page).per(per_page)
                         .where(roles: params[:role])
    else
      @contacts = Contact.order(order_and_direction).page(page).per(per_page)
                         .where(["roles = ? and (lower(name) like ? or email like ? or
                         first_phone like ? or second_phone like ? )",
                                 params[:role], '%' + params[:search].downcase + '%',
                                 '%' + params[:search] + '%',
                                 '%' + params[:search] + '%',
                                 '%' + params[:search] + '%'])
    end

    set_pagination_headers :contacts
    json_string = ContactSerializer.new(@contacts, include: [:properties])
                                   .serialized_json
    render json: json_string


  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    ids = params[:id].split(',')
    if ids.length != 1
      Contact.where(id: params[:id].split(',')).destroy_all
    else
      Contact.find(params[:id]).destroy
    end

  rescue ActiveRecord::InvalidForeignKey => e
  render json: {
      code: 'E001',
      message: 'This contact has a property'
  },  status: 406



  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def contact_params
    params.permit(:name, :first_phone, :email, :second_phone, :roles, :slug_id)
  end
end
