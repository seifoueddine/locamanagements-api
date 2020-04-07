class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :first_phone
      t.string :email
      t.string :second_phone
      t.string :roles

      t.timestamps
    end
  end
end
