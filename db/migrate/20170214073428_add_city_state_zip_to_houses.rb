class AddCityStateZipToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :city_state_zip, :string
  end
end
