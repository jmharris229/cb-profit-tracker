class AddFundsTable < ActiveRecord::Migration[5.2]
  def change

    create_table :funds, :force => true do |t|
      t.column :currency, :string
      t.column :amount, :integer
      t.column :crypto_currency, :string
      t.references :user, foreign_key: true

      t.timestamps null: false
    end

  end
end
