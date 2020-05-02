class  Api::V1::DashboardController < ApplicationController


  def appointments
    slug_id = get_slug_id
    afterDays = Date.today + params[:days].to_i
    @appointments = Appointment.where(slug_id: slug_id)
                               .where("(start_time >= ? AND start_time <= ? )",
                                Date.today , afterDays)
    important_count = @appointments.where(important: true).count
    visit_count = @appointments.where(service: 'visit').count
    call_count = @appointments.where(service: 'call').count
    stats = {stats: { important_count: important_count, visit_count: visit_count , call_count: call_count }}
    json_string = AppointmentSerializer.new(@appointments)

    render json: [json_string, stats]
  end


end
