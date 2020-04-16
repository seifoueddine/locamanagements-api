class AddColumnsToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :type, :string
    add_column :properties, :surface, :string
    add_column :properties, :address, :string
    add_column :properties, :wilaya, :string
    add_column :properties, :city, :string
    add_column :properties, :owner_price, :string
    add_column :properties, :agency_price, :string
    add_column :properties, :transaction_type, :string
    add_column :properties, :nbr_of_pieces, :integer
    add_column :properties, :is_furnished, :boolean
    add_column :properties, :is_equipped, :boolean
    add_column :properties, :has_elevator, :boolean
    add_column :properties, :has_floors, :integer
    add_column :properties, :floor, :integer
    add_column :properties, :has_garage, :boolean
    add_column :properties, :has_garden, :boolean
    add_column :properties, :has_swimming_pool, :boolean
    add_column :properties, :has_sanitary, :boolean
  end
end
