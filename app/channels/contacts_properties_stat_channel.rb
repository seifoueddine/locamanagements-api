class ContactsPropertiesStatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'contacts_properties_stat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
     stop_all_streams
  end
end
