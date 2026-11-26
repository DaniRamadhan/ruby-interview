# frozen_string_literal: true

require_relative "lib/latest_stock_price/version"

Gem::Specification.new do |spec|
  spec.name = "latest_stock_price"
  spec.version = LatestStockPrice::VERSION
  spec.authors = ["Your Name"]
  spec.summary = "Ruby client for the Latest Stock Price API on RapidAPI"
  spec.description = "Provides price, prices and price_all on top of the Latest Stock Price API, using only the Ruby standard library."
  spec.required_ruby_version = ">= 3.2.0"

  spec.files = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]
end
