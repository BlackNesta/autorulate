class AddCcToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :cc, :integer
  end
end
