class ChangeDashboardJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    ActionCable.server.broadcast 'dashboard_channel', appointment: appointment
  end
end
