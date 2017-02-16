class AddPageToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :page, :text
  end
end
