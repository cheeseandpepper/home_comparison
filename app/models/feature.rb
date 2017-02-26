class Feature < ApplicationRecord

  belongs_to :house, touch: true
  belongs_to :feature_type

  default_scope { order('lower (name)') }

  after_save :update_feature_type
  after_commit :update_house_score

  def hard_weight
    hard_coded_weight = nil
    case name
    when "access"
      hard_coded_weight = 7
    when "appliances"
      hard_coded_weight = 7
    when "backyard"
      hard_coded_weight = 10
    when "bathrooms"
      hard_coded_weight = 6
    when "bedrooms"
      hard_coded_weight = 7
    when "central_air"
      hard_coded_weight = 4
    when "central_heat"
      hard_coded_weight = 4
    when "character"
      hard_coded_weight = 8
    when "garage"
      hard_coded_weight = 4
    when "kitchen"
      hard_coded_weight = 8
    when "location"
      hard_coded_weight = 8
    when "porch"
      hard_coded_weight = 6
    when "shed"
      hard_coded_weight = 6
    when "view"
      hard_coded_weight = 9
    else
      hard_coded_weight = 1
    end
    hard_coded_weight
  end

  def update_feature_type
    self.feature_type.update!(weight: self.weight)
  end

  def update_house_score
    House.all.each do |h|
      h.calculate_score
    end
  end

end
