module Factories
  class HouseFactory
    attr_reader :data, :house
    
    def initialize(data)
      @data = data
      @house = House.new(build_params)
    end

    def build_params
      {
        link:      data.links[:homedetails],
        image_url: nil,
        price:     data.price,
        address:   data.address[:street],
        baths:     data.bathrooms,
        beds:      data.bedrooms
      }
    end
  end
end