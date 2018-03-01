require 'test_helper'

class LoadControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
