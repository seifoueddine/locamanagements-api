class FixRefInProperties < ActiveRecord::Migration[6.0]
  def change
    change_column :properties, :contract_id, :bigint, null: true
  end
end
