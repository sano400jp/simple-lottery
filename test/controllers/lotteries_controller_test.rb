require 'test_helper'

class LotteriesControllerTest < ActionController::TestCase
  setup do
    @lottery = lotteries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lotteries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lottery" do
    assert_difference('Lottery.count') do
      post :create, lottery: { code: @lottery.code, draw_time: @lottery.draw_time, end_time: @lottery.end_time, nonres_redraw: @lottery.nonres_redraw, owner_code: @lottery.owner_code, redraw_range: @lottery.redraw_range, title: @lottery.title }
    end

    assert_redirected_to lottery_path(assigns(:lottery))
  end

  test "should show lottery" do
    get :show, id: @lottery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lottery
    assert_response :success
  end

  test "should update lottery" do
    patch :update, id: @lottery, lottery: { code: @lottery.code, draw_time: @lottery.draw_time, end_time: @lottery.end_time, nonres_redraw: @lottery.nonres_redraw, owner_code: @lottery.owner_code, redraw_range: @lottery.redraw_range, title: @lottery.title }
    assert_redirected_to lottery_path(assigns(:lottery))
  end

  test "should destroy lottery" do
    assert_difference('Lottery.count', -1) do
      delete :destroy, id: @lottery
    end

    assert_redirected_to lotteries_path
  end
end
