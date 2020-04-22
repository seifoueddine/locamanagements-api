class ChangePriceTypeToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :properties, :owner_price, :integer, using: 'owner_price::integer'
    change_column :properties, :agency_price, :integer, using: 'agency_price::integer'
  end
end
