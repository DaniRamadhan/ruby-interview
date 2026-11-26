class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.string :type, null: false
      t.references :source_wallet, foreign_key: { to_table: :wallets }
      t.references :target_wallet, foreign_key: { to_table: :wallets }
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :description

      t.timestamps
    end

    add_check_constraint :transactions, "amount > 0", name: "amount_positive"
    add_check_constraint :transactions,
      "source_wallet_id IS NOT NULL OR target_wallet_id IS NOT NULL",
      name: "has_at_least_one_wallet"
    add_check_constraint :transactions,
      "source_wallet_id IS DISTINCT FROM target_wallet_id",
      name: "different_wallets"
  end
end
