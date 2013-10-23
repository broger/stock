require 'test_helper'

class ProductoStocksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:producto_stocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producto_stock" do
    assert_difference('ProductoStock.count') do
      post :create, :producto_stock => { }
    end

    assert_redirected_to producto_stock_path(assigns(:producto_stock))
  end

  test "should show producto_stock" do
    get :show, :id => producto_stocks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => producto_stocks(:one).to_param
    assert_response :success
  end

  test "should update producto_stock" do
    put :update, :id => producto_stocks(:one).to_param, :producto_stock => { }
    assert_redirected_to producto_stock_path(assigns(:producto_stock))
  end

  test "should destroy producto_stock" do
    assert_difference('ProductoStock.count', -1) do
      delete :destroy, :id => producto_stocks(:one).to_param
    end

    assert_redirected_to producto_stocks_path
  end
end
