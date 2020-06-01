class AddSubscriptionTypeToSlugs < ActiveRecord::Migration[6.0]
  def change
    add_column :slugs, :subscription_type, :string
  end
end
