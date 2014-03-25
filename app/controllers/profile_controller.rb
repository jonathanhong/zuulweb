class ProfileController < ApplicationController
  def index
	@user = User.where(username: "jhong")
  end
end
