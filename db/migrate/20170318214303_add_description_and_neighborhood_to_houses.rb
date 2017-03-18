class AddDescriptionAndNeighborhoodToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :neighborhood, :string
    add_column :houses, :description, :text
  end
end
