class ChangeAppointmentsJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    # current_user = User.find(current_user_id)
    ActionCable.server.broadcast 'appointment_channel', data: 'Create new appointment'
  end

end
