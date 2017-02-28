class FeatureType < ApplicationRecord
  has_many :features
  
  DEFAULTS = {
    bedrooms:     6,
    bathrooms:    7,
    backyard:     10,
    kitchen:      7,
    appliances:   6,
    central_air:  5,
    central_heat: 5,
    garage:       2,
    shed:         4,
    porch:        3,
    view:         9,
    access:       7,
    location:     7,
    character:    8
  }

  default_scope { order("lower (name)") }
  after_create :apply_new_feature
  after_commit :update_all_features, if: Proc.new { |ft| ft.name_changed? }
  before_destroy :remove_from_houses

  def update_all_features
    features = Feature.where(feature_type_id: self.id)
    features.update_all!(name: self.name, weight: self.weight)
  end
  
  def remove_from_houses
    Feature.find_by(feature_type_id: id)&.destroy
    House.all.each(&:touch)
  end

  def apply_new_feature
    House.all.each do |h|
      h.features << Feature.new(house_id: h.id, feature_type_id: id, score: 5, weight: weight, name: name)
    end
  end
end
