class ShopController < ApplicationController
  def index
    @users = User.all.order("username ASC")
    @user_count = User.count
    @items = Item.where(active: true)
    @item_count = @items.size
  end
  
  def purchase
	#retrieve POST data [{"itemids" : {array, of, itemids}, userid}]
	#UPDATE quantity in item table
	#SELECT item prices from item table
	#UPDATE balance in user table
	#ADD log in transactions table
	
	#return success or fail code
  end
end
