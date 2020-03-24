class AddSlugReferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :slug, foreign_key: true
  end
end
