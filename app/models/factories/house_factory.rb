module Factories
  class HouseFactory
    attr_reader :data, :house
    
    def initialize(data)
      return if data.message =~ /Error/
      @data = data
      @house = House.new(build_params)
    end

    def build_params
      {
        link:       data.links[:homedetails],
        price:      data.price,
        address:    data.address[:street],
        baths:      data.bathrooms,
        beds:       data.bedrooms,
        house_ref:  data.zpid,
        lot_size:   data.lot_size_square_feet.to_i,
        house_size: data.finished_square_feet.to_i
      }
    end
  end
end