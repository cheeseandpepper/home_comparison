class House < ApplicationRecord

  has_many :features
  after_touch :calculate_score
  after_create :build_feature_factory
  #after_create :fetch_extra_details  

  def build_feature_factory
    Factories::FeatureFactory.new(self.id)
  end


  def fetch_extra_details
    data = Rubillow::PropertyDetails.updated_property_details(zpid: house_ref)
    
  end

  def overall_score
    ((score / max_score) * 100).round(2)
  end

  def calculate_score
    score = 0
    max_score = 0
    features.each do |feature|
     max_score = (max_score + (100 * feature.weight))
     score     = (score + (feature.score * feature.weight))
    end
    self.max_score = max_score
    self.score = score
    save!
  end
end
