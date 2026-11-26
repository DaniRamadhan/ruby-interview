# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  { name: "Budi", email: "budi@mail.com" },
  { name: "Sari", email: "sari@mail.com" }
].each do |attrs|
  User.find_or_create_by!(email: attrs[:email]) do |user|
    user.name = attrs[:name]
    user.password = "password123"
  end
end

Team.find_or_create_by!(name: "Tim A")
Stock.find_or_create_by!(symbol: "AAPL") { |stock| stock.name = "Apple Inc." }
