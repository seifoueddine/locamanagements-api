class ChangeColumnNameInProperties < ActiveRecord::Migration[6.0]
  def change
    rename_column :properties, :type, :property_type
  end
end
