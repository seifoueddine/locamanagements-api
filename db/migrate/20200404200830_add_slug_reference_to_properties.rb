class AddSlugReferenceToProperties < ActiveRecord::Migration[6.0]
  def change
    add_reference :properties, :slug, null: false, foreign_key: true
  end
end
