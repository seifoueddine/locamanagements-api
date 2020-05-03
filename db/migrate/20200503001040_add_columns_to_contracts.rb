class AddColumnsToContracts < ActiveRecord::Migration[6.0]
  def change
    add_reference :contracts, :slug, null: false, foreign_key: true
    add_reference :contracts, :contact, null: false, foreign_key: true
    add_reference :contracts, :user, null: false, foreign_key: true
    add_column :contracts, :property_id, :integer, null: false
  end
end
