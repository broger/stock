require 'test_helper'

class MonedasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monedas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create moneda" do
    assert_difference('Moneda.count') do
      post :create, :moneda => { }
    end

    assert_redirected_to moneda_path(assigns(:moneda))
  end

  test "should show moneda" do
    get :show, :id => monedas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => monedas(:one).to_param
    assert_response :success
  end

  test "should update moneda" do
    put :update, :id => monedas(:one).to_param, :moneda => { }
    assert_redirected_to moneda_path(assigns(:moneda))
  end

  test "should destroy moneda" do
    assert_difference('Moneda.count', -1) do
      delete :destroy, :id => monedas(:one).to_param
    end

    assert_redirected_to monedas_path
  end
end
