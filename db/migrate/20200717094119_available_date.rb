class AvailableDate < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :available, :boolean
    add_column :properties, :available_start_date, :timestamp
    add_column :properties, :available_end_date, :timestamp
  end
end
