# frozen_string_literal: true

require_relative "latest_stock_price/version"
require_relative "latest_stock_price/configuration"
require_relative "latest_stock_price/client"

module LatestStockPrice
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
