class AddActiveToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :active, :boolean, default: true
  end
end
