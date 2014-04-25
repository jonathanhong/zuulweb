class ProfileController < ApplicationController
  def index
		#TODO: add user auth
		@user = User.find_by username: 'jhong'
		@transactions = @user.transactions.limit(5)
  end
end
