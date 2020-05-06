class AddSlugIdToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :slug, null: false, foreign_key: true
  end
end
