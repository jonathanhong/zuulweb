class ShopController < ApplicationController
  def index
    @user_count = User.count
    @items = Item.where(active: true)
    @item_count = @items.size
  end
end
