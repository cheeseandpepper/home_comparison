class AddScoreToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :score, :float
    add_column :houses, :max_score, :float
  end
end
