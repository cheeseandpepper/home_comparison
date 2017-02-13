class CreateFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :features do |t|
      t.string        :name
      t.float         :score
      t.float         :weight
      t.integer       :house_id
      t.timestamps
    end
  end
end
