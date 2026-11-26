class Stock < ApplicationRecord
  include HasWallet

  normalizes :symbol, with: ->(symbol) { symbol.strip.upcase }

  validates :symbol, presence: true, uniqueness: true
  validates :name, presence: true
end
