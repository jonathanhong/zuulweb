class AddAdminLogTable < ActiveRecord::Migration
  def change
      create_table :admin_log do |t|
          t.integer     :itemid
          t.integer     :userid
          t.integer     :amount
          t.decimal     :price
          t.decimal     :cost 
          t.timestamps
    end
   execute <<-SQL
          ALTER TABLE admin_log 
          ADD CONSTRAINT fk_admin_log_users
          FOREIGN KEY (userid)
          REFERENCES users(id);
          
          ALTER TABLE admin_log 
          ADD CONSTRAINT fk_admin_log_items
          FOREIGN KEY (itemid)
          REFERENCES items(id);
   SQL
  end
end
