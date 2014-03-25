class ProfileController < ApplicationController
  def index
	@user = User.find_by username: 'jhong'
  end
end
