class AddAddressToSlugs < ActiveRecord::Migration[6.0]
  def change
    add_column :slugs, :wilaya, :string
    add_column :slugs, :city, :string
  end
end
