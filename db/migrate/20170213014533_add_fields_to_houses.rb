class AddFieldsToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :name,    :string
    add_column :houses, :price,   :integer
    add_column :houses, :address, :string
    add_column :houses, :link,    :string
  end
end
