require 'test_helper'

class GpsControllerTest < ActionController::TestCase
  setup do
    @gp = gps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gp" do
    assert_difference('Gp.count') do
      post :create, gp: { lat: @gp.lat, lon: @gp.lon }
    end

    assert_redirected_to gp_path(assigns(:gp))
  end

  test "should show gp" do
    get :show, id: @gp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gp
    assert_response :success
  end

  test "should update gp" do
    patch :update, id: @gp, gp: { lat: @gp.lat, lon: @gp.lon }
    assert_redirected_to gp_path(assigns(:gp))
  end

  test "should destroy gp" do
    assert_difference('Gp.count', -1) do
      delete :destroy, id: @gp
    end

    assert_redirected_to gps_path
  end
end
