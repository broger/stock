require 'test_helper'

class MovimientosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movimientos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movimiento" do
    assert_difference('Movimiento.count') do
      post :create, :movimiento => { }
    end

    assert_redirected_to movimiento_path(assigns(:movimiento))
  end

  test "should show movimiento" do
    get :show, :id => movimientos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => movimientos(:one).to_param
    assert_response :success
  end

  test "should update movimiento" do
    put :update, :id => movimientos(:one).to_param, :movimiento => { }
    assert_redirected_to movimiento_path(assigns(:movimiento))
  end

  test "should destroy movimiento" do
    assert_difference('Movimiento.count', -1) do
      delete :destroy, :id => movimientos(:one).to_param
    end

    assert_redirected_to movimientos_path
  end
end
