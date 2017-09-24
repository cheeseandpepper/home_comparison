class CompsController < ApplicationController
  before_action :set_house
  
  def index
    @comps_link = "https://www.zillow.com/homes/comps/#{@house.house_ref}_zpid/"
    @comps_page = HTTParty.get(@comps_link, headers: {"User-Agent" => USER_AGENT})
    page = Nokogiri::XML(@comps_page)
    @comps_object = comps_object(page)    
  end

  def comps_object(doc)
    listing_objects = doc.css(".property-listing")
    comps = []
    listing_objects.each do |obj|
      return unless obj.present?
      comps << OpenStruct.new(
        image:         obj.css("img").first.attributes["src"].value,
        address:       obj.css(".listing-address").first.text.strip,
        price:         obj.css(".listing-price").text.strip,
        comp_greater:  obj.css(".listing-price").text.strip.delete("Sold: $,").to_i > @house.price,
        more_diff:     obj.css(".facts-diff_more").text.strip,
        less_diff:     obj.css(".facts-diff_less").text.strip,
        details:       obj.css(".listing-details").text.strip,
        date_sold:     obj.css(".listing-date-sold").text.strip,
        external_link: zillow_link_for(obj.get_attribute("data-zpid"))
        )
    end
    comps
  end

  def zillow_link_for(external_id)
    "https://www.zillow.com/homedetails/#{external_id}_zpid/"
  end

  def comp_price_is_greater(house, comp)
    house.price 
  end

  def set_house
    @house = House.find(params[:house_id])
  end
end
