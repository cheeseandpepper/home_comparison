class House < ApplicationRecord

  has_many :features
  after_touch :calculate_score
  after_create :build_feature_factory
  

  def build_feature_factory
    Factories::FeatureFactory.new(self.id)
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

  # var calculate = function(event) {
  #   var houseId = $('#house-list option:selected').attr('id')
    
  #   //updateFeature();


  #   var rows = $('tbody tr')
  #   var value = 0;
  #   var maxValue = 0;
  #   var rowCount = rows.length;
  #   var featureObject = {};
    
  #   rows.each(function(i, e) {
  #     var featureScore = parseInt($(e).find('.feature-score').val());
  #     var featureWeight = parseInt($(e).find('.feature-weight').val());
  #     maxValue = maxValue + (100 * featureWeight);
  #     value = value + (featureScore * featureWeight)
  #     //
  #   })
  
  #   $('#house-score').html(value)
  #   $('#house-max-score').html(maxValue)
  #   $('#overall-score').html(parseFloat((value / maxValue)) * 100)

end
