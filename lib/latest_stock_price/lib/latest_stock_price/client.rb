# frozen_string_literal: true

require "net/http"
require "json"
require "uri"

module LatestStockPrice
  class Client
    def initialize(api_key: LatestStockPrice.configuration.api_key,
                   host: LatestStockPrice.configuration.host,
                   timeout: LatestStockPrice.configuration.timeout)
      raise Error, "RapidAPI key is missing" if api_key.to_s.empty?

      @api_key = api_key
      @host = host
      @timeout = timeout
    end

    # All stocks.
    def price_all
      get("/any")
    end

    # One stock by symbol, or nil if not found.
    def price(symbol)
      price_all.find { |stock| stock["symbol"].to_s.casecmp?(symbol.to_s) }
    end

    # Several stocks by symbol.
    def prices(symbols)
      wanted = Array(symbols).map { |symbol| symbol.to_s.upcase }
      price_all.select { |stock| wanted.include?(stock["symbol"].to_s.upcase) }
    end

    private

    def get(path)
      uri = URI("https://#{@host}#{path}")
      request = Net::HTTP::Get.new(uri)
      request["X-RapidAPI-Key"] = @api_key
      request["X-RapidAPI-Host"] = @host

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true,
                                 open_timeout: @timeout, read_timeout: @timeout) do |http|
        http.request(request)
      end

      unless response.is_a?(Net::HTTPSuccess)
        raise Error, "Request failed with status #{response.code}: #{response.body}"
      end

      JSON.parse(response.body)
    rescue Timeout::Error, SocketError, Errno::ECONNREFUSED => e
      raise Error, "Connection failed: #{e.message}"
    rescue JSON::ParserError
      raise Error, "Invalid JSON response"
    end
  end
end
