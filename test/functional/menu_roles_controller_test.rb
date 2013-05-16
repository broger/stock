require 'test_helper'

class MenuRolesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:menu_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create menu_rol" do
    assert_difference('MenuRol.count') do
      post :create, :menu_rol => { }
    end

    assert_redirected_to menu_rol_path(assigns(:menu_rol))
  end

  test "should show menu_rol" do
    get :show, :id => menu_roles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => menu_roles(:one).to_param
    assert_response :success
  end

  test "should update menu_rol" do
    put :update, :id => menu_roles(:one).to_param, :menu_rol => { }
    assert_redirected_to menu_rol_path(assigns(:menu_rol))
  end

  test "should destroy menu_rol" do
    assert_difference('MenuRol.count', -1) do
      delete :destroy, :id => menu_roles(:one).to_param
    end

    assert_redirected_to menu_roles_path
  end
end
