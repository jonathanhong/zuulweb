class ModifyColumnNames < ActiveRecord::Migration
  def change
    rename_column :transactions, :userid, :user_id  
    rename_column :transaction_items, :transactionid, :transaction_id
    rename_column :transaction_items, :itemid, :item_id
    rename_column :admin_log, :itemid, :item_id
    rename_column :admin_log, :userid, :user_id
  end
end
