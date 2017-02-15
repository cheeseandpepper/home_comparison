class ChangeFeatureColumnTypes < ActiveRecord::Migration[5.0]
  def up
    change_column :features, :score, :integer
    change_column :features, :weight, :integer
  end

  def down
    change_column :features, :score, :float
    change_column :features, :weight, :float
  end
end
