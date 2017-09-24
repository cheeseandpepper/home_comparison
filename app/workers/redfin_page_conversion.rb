class RedfinPageConversion
  include Sidekiq::Worker
  
  USER_AGENT = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
  
  def perform(args)
    page = HTTParty.get(params[:url], headers: {"User-Agent" => USER_AGENT})
  end
end