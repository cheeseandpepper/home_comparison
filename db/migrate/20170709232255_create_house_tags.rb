class CreateHouseTags < ActiveRecord::Migration[5.0]
  def change
    create_table :house_tags do |t|
      t.integer :house_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
