class Transaction < ApplicationRecord
  TYPES = %w[Credit Debit Transfer].freeze

  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true

  validates :type, inclusion: { in: TYPES }
  validates :amount, numericality: { greater_than: 0 }

  def readonly?
    persisted?
  end

  private

  def source_wallet_has_sufficient_balance
    return if source_wallet.nil? || amount.nil?

    if source_wallet.balance < amount
      errors.add(:source_wallet, "exceeds available balance")
    end
  end
end
