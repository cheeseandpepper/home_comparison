module Factories
  class FeatureFactory
    
    def initialize(house_id)
      build_features!(house_id)
    end

    def features
      %w(
        bedrooms
        bathrooms
        backyard
        kitchen
        appliances
        central_air
        central_heat
        garage
        shed
        porch
        view
        access
        location
        character
      )
    end

    def build_features!(house_id)
      features.each do |feature|
        Feature.create!(name: feature, score: 1, weight: 1, house_id: house_id)
      end
      
    end
  
  end
end