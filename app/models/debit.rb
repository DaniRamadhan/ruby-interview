class Debit < Transaction
  validates :source_wallet, presence: true
  validates :target_wallet_id, absence: true
  validate :source_wallet_has_sufficient_balance, on: :create
end
