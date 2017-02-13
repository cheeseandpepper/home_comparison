module Factories
  class HouseFactory
    attr_reader :doc, :house
    
    def initialize(html)
      @doc = Nokogiri::HTML(html)
      @house = House.new(build_params)
    end

    def build_params
      {
        image_url: @doc.css('img').attr('src').value,
        price: @doc.css("span[itemprop='price']").attr('content').value,
        address: @doc.css('img').attr('title'),
        baths: @doc.css(".info-block[data-rf-test-id='abp-baths']").children.first.text,
        beds: @doc.css(".info-block[data-rf-test-id='abp-beds']").children.first.text
      }
    end
  end
end