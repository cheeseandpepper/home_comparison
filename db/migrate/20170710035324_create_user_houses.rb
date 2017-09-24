class CreateUserHouses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_houses do |t|
      t.integer :user_id
      t.integer :house_id
      t.timestamps
    end
  end
end
