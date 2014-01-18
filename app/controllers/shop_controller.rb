class ShopController < ApplicationController
  def index
    @user_count = User.count
    @item_count = Item.count
  end
end
