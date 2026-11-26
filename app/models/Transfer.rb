class Transfer < Transaction
  validates :source_wallet, :target_wallet, presence: true
  validate :wallets_must_be_different, on: :create
  validate :source_wallet_has_sufficient_balance, on: :create

  private

  def wallets_must_be_different
    if source_wallet_id.present? && source_wallet_id == target_wallet_id
      errors.add(:target_wallet, "must be different from source wallet")
    end
  end
end
