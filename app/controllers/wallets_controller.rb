class WalletsController < ApplicationController
  def mine
    render json: wallet_json(current_wallet)
  end

  def transactions
    records = current_wallet.transactions.order(created_at: :desc).limit(50)
    render json: records.map { |transaction| transaction_json(transaction) }
  end

  def deposit
    transaction = WalletService.deposit(
      wallet: current_wallet, amount: params[:amount], description: params[:description])
    render json: transaction_json(transaction), status: :created
  end

  def withdraw
    transaction = WalletService.withdraw(
      wallet: current_wallet, amount: params[:amount], description: params[:description])
    render json: transaction_json(transaction), status: :created
  end

  def transfer
    target_wallet = Wallet.find_by!(id: params[:target_wallet_id])
    transaction = WalletService.transfer(
      from: current_wallet,
      to: target_wallet,
      amount: params[:amount],
      description: params[:description]
    )
    render json: transaction_json(transaction), status: :created
  end

  def index
    wallets = Wallet.includes(:owner).order(:id)
    render json: wallets.map { |wallet| wallet_json(wallet) }
  end

  private

  def wallet_json(wallet)
    {
      id: wallet.id,
      owner_id: wallet.owner_id,
      owner_type: wallet.owner_type,
      owner_name: wallet.owner.name,
      balance: wallet.balance
    }
  end

  def transaction_json(transaction)
    {
      id: transaction.id,
      type: transaction.type,
      source_wallet_id: transaction.source_wallet_id,
      target_wallet_id: transaction.target_wallet_id,
      amount: transaction.amount,
      description: transaction.description,
      created_at: transaction.created_at
    }
  end

  def current_wallet
    current_user.wallet
  end
end
