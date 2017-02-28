class House < ApplicationRecord

  has_many :features
  has_many :house_images
  after_touch :calculate_score, if: Proc.new { |h| h.has_score? }
  after_create :build_feature_factory
  #after_create :fetch_extra_details  

  def has_score?
    score.present?
  end

  def build_feature_factory
    Factories::FeatureFactory.new(self.id)
  end


  def fetch_extra_details
    data = Rubillow::PropertyDetails.updated_property_details(zpid: house_ref)
  end

  def overall_score
    score&.round(2)
  end

  def updated_property_details
    Rubillow::PropertyDetails.updated_property_details({ zpid: house_ref })
  end

  def deep_comps(count)
    Rubillow::PropertyDetails.deep_comps({ zpid: house_ref, count: count })
  end

  def self.deep_search_results(address, citystatezip)
    Rubillow::PropertyDetails.deep_search_results(
      { address: address, citystatezip: citystatezip }
    )
  end

  def calculate_score

    weighted_total = FeatureType.sum(:weight)
    weighted_sum   = features.map {|feature| feature.score * feature.weight}.sum
    score = (weighted_sum.to_f / weighted_total.to_f)
    self.score = score
    save!
  end
end
