class CreateFavoriteListings < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_listings do |t|
      t.integer :listing_id, null: false
      t.string :person_id, null: false

      t.timestamps null: false
    end

    add_index :favorite_listings, [:listing_id, :person_id]
  end
end
