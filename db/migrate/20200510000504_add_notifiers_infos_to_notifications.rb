class AddNotifiersInfosToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :notifier_avatar, :string
    add_column :notifications, :notifier_name, :string
  end
end
