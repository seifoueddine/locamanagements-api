class AddSlugReferenceToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :slug, null: false, foreign_key: true
    add_reference :appointments, :contact, null: false, foreign_key: true
    add_reference :appointments, :user, null: false, foreign_key: true
    add_reference :appointments, :property, null: false, foreign_key: true
  end
end
