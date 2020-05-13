class AddPaymentPeriodesToContracts < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts, :payment_periods, :json

  end
end
