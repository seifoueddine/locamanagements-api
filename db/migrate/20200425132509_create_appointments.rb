class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :label
      t.text :description
      t.string :service
      t.boolean :status
      t.datetime :start_time

      t.timestamps
    end
  end
end
