class RemoveUserIdFromHouse < ActiveRecord::Migration[5.0]
  def change
    remove_column :houses, :user_id
  end
end
