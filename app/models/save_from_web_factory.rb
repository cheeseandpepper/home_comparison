class SaveFromWebFactory

  class UnknownSourceError < StandardError; end
  
  attr_reader :url, :source, :params
  

  def initialize(params)
    @params = params
    @url    = params[:url]
    @source = derive_source_from_url(url)
    
    raise UnknownSourceError unless source
    
    parse_source(url)
  end

  def derive_source_from_url(url)
    url.match(/\.(.+)\.com/).captures.first
  end

  def parse_source(url)
    case source
    when "redfin"
      RedfinPageConversion.perform_async(params)
    else
      # NOOP
    end
  end
end