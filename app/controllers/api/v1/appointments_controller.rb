class Api::V1::AppointmentsController < ApplicationController

  before_action :set_appointment, only: %i[show update]

  # GET /appointments
  def index
    slug_id = get_slug_id
    params[:slug_id] = slug_id
    if params[:search].blank?
      @appointments = Appointment.order(order_and_direction).page(page).per(per_page)
                                 .where(slug_id: params[:slug_id])
    else
      @appointments = Appointment.joins(:contact).order(order_and_direction)
                                 .page(page).per(per_page)
                                 .where(slug_id: params[:slug_id])
                                 .where(["(lower(label) like ?
                                  or lower(contacts.name) like ? )",
                                  '%' + params[:search].downcase + '%',
                                  '%' + params[:search].downcase + '%',
                                  ])
    end
    set_pagination_headers :appointments

    json_string = AppointmentSerializer.new(@appointments, include: %i[property contact])
                                       .serialized_json
    render json: json_string
  end

  # GET /appointments-calendar
  def calendar_appointments
    slug_id = get_slug_id
    params[:slug_id] = slug_id
    @appointments = Appointment.where(slug_id: params[:slug_id]).where(start_time: params[:firstDay]..params[:lastDay])


    json_string = AppointmentSerializer.new(@appointments, include: %i[property contact])
                                       .serialized_json
    render json: json_string
  end

  # GET /appointments/1
  def show
    json_string = AppointmentSerializer.new(@appointment, include: %i[properties contacts])
                                       .serialized_json
    render json: json_string
  end

  # POST /appointments
  def create
    slug_id = get_slug_id
    params[:slug_id] = slug_id
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    ids = params[:id].split(',')
    if ids.length != 1
      Appointment.where(id: params[:id].split(',')).destroy_all
    else
      Appointment.find(params[:id]).destroy
    end

  rescue ActiveRecord::InvalidForeignKey => e
    render json: {
        code: 'E001',
        message: 'This appointment has a property'
    },  status: 406



  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def appointment_params
    params.permit(:label, :description, :status, :contact_id, :slug_id,
                  :property_id, :service, :user_id, :start_time, :important)
  end
  
  
end
