class NotificationsJob < ApplicationJob
  queue_as :default

  def perform(type)

     var = type
     case var
     when 'create_appointment'
       ActionCable.server.broadcast 'notifications_channel', data: 'Create new appointment'

     when 'update_appointment'
       ActionCable.server.broadcast 'notifications_channel', data: 'Update appointment'
     end

  end
end
