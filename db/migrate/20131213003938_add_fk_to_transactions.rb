class AddFkToTransactions < ActiveRecord::Migration
  def change
    execute <<-SQL
          ALTER TABLE transactions 
          ADD CONSTRAINT fk_transactions_users
          FOREIGN KEY (userid)
          REFERENCES users(id)
    SQL

  end
end
