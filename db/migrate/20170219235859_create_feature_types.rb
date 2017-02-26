class CreateFeatureTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :feature_types do |t|
      t.string :name
      t.integer :weight
      t.boolean :active

      t.timestamps
    end
  end
end
