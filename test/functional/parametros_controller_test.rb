require 'test_helper'

class ParametrosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parametros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parametro" do
    assert_difference('Parametro.count') do
      post :create, :parametro => { }
    end

    assert_redirected_to parametro_path(assigns(:parametro))
  end

  test "should show parametro" do
    get :show, :id => parametros(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => parametros(:one).to_param
    assert_response :success
  end

  test "should update parametro" do
    put :update, :id => parametros(:one).to_param, :parametro => { }
    assert_redirected_to parametro_path(assigns(:parametro))
  end

  test "should destroy parametro" do
    assert_difference('Parametro.count', -1) do
      delete :destroy, :id => parametros(:one).to_param
    end

    assert_redirected_to parametros_path
  end
end
