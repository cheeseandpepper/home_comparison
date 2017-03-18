class AddCityToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :city, :string
    add_column :houses, :state, :string
    add_column :houses, :zip, :string
  end
end
