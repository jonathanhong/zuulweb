class AddFkFromTransactionsToItems < ActiveRecord::Migration
  def change
      execute <<-SQL
        ALTER TABLE transactions 
        ADD CONSTRAINT fk_transactions_items 
        FOREIGN KEY (itemid)
        REFERENCES items(id);
      SQL
 
  end
end
