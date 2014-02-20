require 'json'

class ShopController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index]
  def index
    @users = User.all.order("username ASC")
    @user_count = User.count
    @items = Item.where(active: true)
    @item_count = @items.size
  end
  
  def purchase
	  #retrieve POST data [{"itemids" : {array, of, itemids}, userid}] multiple id's for multiple purchases of same item
	  postdata = JSON.parse(params[:payload])
    itemids = postdata['itemid']
    User.transaction do
      Transactions.transaction do
        Item.transaction do
          total = 0.0
          itemids.each do |itemid|
            #UPDATE quantity in item table
            currItem = Item.find(itemid)
            currItem.update(quantity: currItem.quantity - 1)
	          #SELECT item prices from item table
            total += currItem.price
  	        #ADD log in transactions table
          end

	          #UPDATE balance in user table
        end
      end
    end
	  render json: itemids 
	  #return success or fail code
  end
end
