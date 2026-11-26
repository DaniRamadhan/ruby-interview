class CreateWallets < ActiveRecord::Migration[8.1]
  def change
    create_table :wallets do |t|
      t.references :owner, polymorphic: true, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
