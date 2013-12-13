class Initial < ActiveRecord::Migration
  def up 
	create_table :users do |t|

		t.string 	:username
		t.decimal 	:balance	
		t.string 	:irchandle
		t.boolean	:admin
 	end
	create_table :items do |t|
		t.string 	:name
		t.integer 	:quantity
		t.decimal	:price
		t.boolean 	:active
 	end	
	
	create_table :transactions do |t|
        t.references    :users
		t.integer		:userid
		t.integer		:itemid
		t.decimal	    :price
		t.integer		:quantity
     
    end	
end
end

