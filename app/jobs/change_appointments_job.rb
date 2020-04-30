class ChangeAppointmentsJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    ActionCable.server.broadcast 'appointment_channel', appointment: appointment
  end

end
