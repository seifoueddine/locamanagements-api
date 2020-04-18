class ChangeSurfaceToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :properties, :surface, :integer, using: 'surface::integer'
  end
end
