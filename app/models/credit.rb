class Credit < Transaction
  validates :target_wallet, presence: true
  validates :source_wallet_id, absence: true
end
