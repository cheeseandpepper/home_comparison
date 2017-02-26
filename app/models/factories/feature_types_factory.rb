module Factories
  class FeatureTypesFactory

    attr_reader :params
    
    def initialize(params)
      @params = params
      update!
    end

    def update!
      params.keys.each do |id|
        feature_type = FeatureType.find(id)
        feature_type.update!(name: params[id]["name"], weight: params[id]["weight"])
      end
    end
  end
end