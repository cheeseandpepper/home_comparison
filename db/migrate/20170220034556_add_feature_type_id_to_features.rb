class AddFeatureTypeIdToFeatures < ActiveRecord::Migration[5.0]
  def change
    add_column :features, :feature_type_id, :integer
  end
end
