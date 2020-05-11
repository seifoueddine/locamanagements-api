class AddRefToProperties < ActiveRecord::Migration[6.0]
  def change
    add_reference :properties, :contract, null: false, foreign_key: true
  end
end
