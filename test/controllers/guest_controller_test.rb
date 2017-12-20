require 'test_helper'

class GuestControllerTest < ActionController::TestCase
  test "should get open_lottery" do
    get :open_lottery
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

end
