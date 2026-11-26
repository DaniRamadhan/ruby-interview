class WalletService
  def self.deposit(wallet:, amount:, description: nil)
    ActiveRecord::Base.transaction do
          Credit.create!(target_wallet: wallet, amount: amount, description: description)
    end
  end

  def self.withdraw(wallet:, amount:, description: nil)
        ActiveRecord::Base.transaction do
          wallet.lock!
          Debit.create!(source_wallet: wallet, amount: amount, description: description)
        end
  end

  def self.transfer(from:, to:, amount:, description: nil)
    ActiveRecord::Base.transaction do
      from.lock!
      Transfer.create!(source_wallet: from, target_wallet: to, amount: amount, description: description)
    end
  end
end
