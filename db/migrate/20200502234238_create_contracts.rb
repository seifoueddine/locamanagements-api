class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.string :contract_type
      t.text :contract_details
      t.integer :payment_frequency_number
      t.string :payment_frequency_name
      t.datetime :payment_date
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
