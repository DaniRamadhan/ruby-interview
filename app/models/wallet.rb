class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true

  has_many :outgoing_transactions, class_name: "Transaction",
    foreign_key: "source_wallet_id", inverse_of: :source_wallet
  has_many :incoming_transactions, class_name: "Transaction",
    foreign_key: "target_wallet_id", inverse_of: :target_wallet

  validates :owner_id, uniqueness: { scope: :owner_type }

  def balance
    incoming_transactions.sum(:amount) - outgoing_transactions.sum(:amount)
  end
end
