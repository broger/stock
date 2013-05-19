require 'test_helper'

class DepositosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:depositos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposito" do
    assert_difference('Deposito.count') do
      post :create, :deposito => { }
    end

    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should show deposito" do
    get :show, :id => depositos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => depositos(:one).to_param
    assert_response :success
  end

  test "should update deposito" do
    put :update, :id => depositos(:one).to_param, :deposito => { }
    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should destroy deposito" do
    assert_difference('Deposito.count', -1) do
      delete :destroy, :id => depositos(:one).to_param
    end

    assert_redirected_to depositos_path
  end
end
