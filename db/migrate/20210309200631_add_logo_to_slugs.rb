class AddLogoToSlugs < ActiveRecord::Migration[6.0]
  def change
    add_column :slugs, :logo, :string
  end
end
