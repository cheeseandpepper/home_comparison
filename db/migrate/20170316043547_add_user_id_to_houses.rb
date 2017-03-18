class AddUserIdToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :user_id, :integer
    add_column :comments, :user_id, :integer
  end
end
