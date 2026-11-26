module HasWallet
    extend ActiveSupport::Concern

    included do
      has_one :wallet, as: :owner, dependent: :restrict_with_exception
      after_create :create_wallet!
    end
end
