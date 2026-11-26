class Session < ApplicationRecord
  TTL = 24.hours

  belongs_to :user
  has_secure_token :token

  before_create { self.expires_at = TTL.from_now }

  scope :active, -> { where("expires_at > ?", Time.current) }
end
