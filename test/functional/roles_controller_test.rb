require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rol" do
    assert_difference('Rol.count') do
      post :create, :rol => { }
    end

    assert_redirected_to rol_path(assigns(:rol))
  end

  test "should show rol" do
    get :show, :id => roles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => roles(:one).to_param
    assert_response :success
  end

  test "should update rol" do
    put :update, :id => roles(:one).to_param, :rol => { }
    assert_redirected_to rol_path(assigns(:rol))
  end

  test "should destroy rol" do
    assert_difference('Rol.count', -1) do
      delete :destroy, :id => roles(:one).to_param
    end

    assert_redirected_to roles_path
  end
end
