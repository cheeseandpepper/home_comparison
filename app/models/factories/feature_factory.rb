module Factories
  class FeatureFactory
    
    def initialize(house_id)
      build_features!(house_id)
      build_images!(house_id)
    end

    def feature_types
      FeatureType.all
    end

    def build_features!(house_id)
      feature_types.each do |ft|
        Feature.create!(name: ft.name, score: 1, weight: ft.weight, house_id: house_id, feature_type_id: ft.id)
      end
    end

    def build_images!(house_id)
      house = House.find house_id
      urls = Nokogiri::XML(house.page).css('.hip-photo')
                                      .map { |i| i.attr('href') }
                                      .compact
                                      .select { |l| l[-4..-1] == ".jpg" }

      urls.each do |url|
        HouseImage.create!(url: url, house_id: house_id)
      end
    end
  
  end
end