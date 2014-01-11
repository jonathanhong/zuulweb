require 'test_helper'

class GitControllerTest < ActionController::TestCase
  test "should get deploy" do
    get :deploy
    assert_response :success
  end

end
