class AddContactReferenceToProperties < ActiveRecord::Migration[6.0]
  def change
    add_reference :properties, :contact, null: false, foreign_key: true
  end
end
