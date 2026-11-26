LatestStockPrice.configure do |config|
  config.api_key = ENV["RAPIDAPI_KEY"]
  config.timeout = 10
end
