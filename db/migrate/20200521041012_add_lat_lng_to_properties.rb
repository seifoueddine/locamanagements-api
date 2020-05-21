class AddLatLngToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :lat, :decimal, { precision: 10, scale: 6 }
    add_column :properties, :lng, :decimal, { precision: 10, scale: 6 }
  end
end
