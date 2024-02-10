class DropNotifiTable < ActiveRecord::Migration[6.0]
  def change
    #drop_table :notifications
    drop_table :subscriptions
  end
end
