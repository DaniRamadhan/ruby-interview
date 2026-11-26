# frozen_string_literal: true

module LatestStockPrice
  class Configuration
    DEFAULT_HOST = "latest-stock-price.p.rapidapi.com"

    attr_accessor :api_key, :host, :timeout

    def initialize
      @api_key = ENV["RAPIDAPI_KEY"]
      @host = DEFAULT_HOST
      @timeout = 10
    end
  end
end
