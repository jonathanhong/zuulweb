class ProfileController < ApplicationController
  def index
		#TODO: add user auth
		@user = User.find_by username: 'jhong'
		@transactions = Transaction.where("userid = ?", @user.id).limit(5).order('created_at desc')	
  end
end
