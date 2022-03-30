class EditPostTable < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :location, :string
    add_column :posts, :body, :string
    add_column :posts, :brand, :string
    add_column :posts, :model, :string
    add_column :posts, :year, :integer
    add_column :posts, :price, :integer
    add_column :posts, :mileage, :integer
    add_column :posts, :fuel, :string
    add_column :posts, :power, :integer
    add_column :posts, :transmition, :string
    add_column :posts, :gearbox, :string
  end
end
