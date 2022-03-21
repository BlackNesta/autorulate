class CreateUserFavoriteCars < ActiveRecord::Migration[6.1]
  def change
    create_table :user_favorite_cars do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    add_index :user_favorite_cars, :user_id
    add_index :user_favorite_cars, :post_id
    add_index :user_favorite_cars, [:user_id, :post_id], unique: true
  end
end
