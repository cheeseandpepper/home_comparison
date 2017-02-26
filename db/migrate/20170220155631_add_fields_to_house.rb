class AddFieldsToHouse < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :lot_size, :integer
    add_column :houses, :house_size, :integer
  end
end
