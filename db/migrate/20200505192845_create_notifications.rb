class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :target_type, null: false
      t.bigint :target_id, null: false
      t.text :data
      t.bigint :notifier_id, null: false
      t.datetime :opened_at
      t.boolean :read

      t.timestamps
    end
  end
end
