class AddThemeColorAndLanguageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :wilaya, :string
    add_column :users, :city, :string
    add_column :users, :theme_color, :string
    add_column :users, :language, :string
  end
end
