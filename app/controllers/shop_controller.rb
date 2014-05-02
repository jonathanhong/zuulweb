require 'json'

class ShopController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:index]
  def index
    @users = User.all.order("username ASC")
    @user_count = @users.size
    @items = Item.where(active: true)
    @item_count = @items.size
  end
  
  def purchase
    #retrieve POST data [{"itemids" : [array, of, itemids], userid}] multiple id's for multiple purchases of same item
    begin
      data = JSON.parse(request.body.read)
      item_ids = data['itemid']
      user_id = data['userid']
      User.transaction do
        Transactions.transaction do
          Item.transaction do
            total = 0.0
	    transaction = Transaction.create(userid: user_id)
            item_ids.each do |itemid|
              #UPDATE quantity in item table
              currItem = Item.find(itemid)
              currItem.update(quantity: currItem.quantity - 1)
              #SELECT item prices from item table
              total += currItem.price
              #ADD log in transactions table
	      
            end
              #UPDATE balance in user table
              currUser = User.find(user_id)
	      currUser.update(balance: currUser.balance - total)
          end
        end
      end
      #return success or fail code
      render json: itemids
    rescue Exception
      render json: {}
    end
  end
end
