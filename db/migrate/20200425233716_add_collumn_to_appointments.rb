class AddCollumnToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :important, :boolean
  end
end
