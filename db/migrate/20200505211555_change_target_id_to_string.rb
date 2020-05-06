class ChangeTargetIdToString < ActiveRecord::Migration[6.0]
  def change
    change_column :notifications, :target_id, :string
  end
end
