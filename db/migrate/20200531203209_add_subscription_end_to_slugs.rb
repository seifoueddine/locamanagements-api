class AddSubscriptionEndToSlugs < ActiveRecord::Migration[6.0]
  def change
    add_column :slugs, :subscription_end, :timestamp
  end
end
