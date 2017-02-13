class AddBedsAndBathsToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :beds, :integer
    add_column :houses, :baths, :float
  end
end
