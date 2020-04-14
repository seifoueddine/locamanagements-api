class AddSlugReferenceToContacts < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts, :slug, null: false, foreign_key: true

  end
end
