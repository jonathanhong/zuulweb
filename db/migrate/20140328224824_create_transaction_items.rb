class CreateTransactionItems < ActiveRecord::Migration
  def change
    create_table :transaction_items, {:id => false, :force => true} do |t|
      t.integer :itemid
      t.integer :transactionid
      t.integer :quantity 
    end

    remove_column :transactions, :itemid
    remove_column :transactions, :quantity
  end
end
