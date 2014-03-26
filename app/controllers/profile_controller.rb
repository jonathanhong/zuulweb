class ProfileController < ApplicationController
  def index
	@user = User.find_by username: 'jhong'
	@transactions = Transaction.where("userid = ? LIMIT 5", @user.id).order(created_at: desc)
  end
end
