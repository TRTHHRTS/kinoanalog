require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get details" do
    get :details
    assert_response :success
  end

end
