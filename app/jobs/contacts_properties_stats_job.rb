class ContactsPropertiesStatsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
     ActionCable.server.broadcast 'contacts_properties_stat_channel', data: 'New stats'
  end
end
