class AddImagesToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :images, :string, array: true, default: [] # add images column as array

  end
end
