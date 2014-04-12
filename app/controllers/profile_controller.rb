class ProfileController < ApplicationController
  def index
		#TODO: add user auth
		@user = User.find_by username: 'jhong'
		@transactions = User.transactions.limit(5)
  end
end
