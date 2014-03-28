class MovePrice < ActiveRecord::Migration
  def change
    remove_column :transactions, :price
    add_column :transaction_items, :price, :decimal
  end
end
