class CreateSlugs < ActiveRecord::Migration[6.0]
  def change
    create_table :slugs do |t|
      t.string :name

      t.timestamps
    end
  end
end
