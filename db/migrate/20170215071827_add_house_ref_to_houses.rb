class AddHouseRefToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :house_ref, :string
  end
end
