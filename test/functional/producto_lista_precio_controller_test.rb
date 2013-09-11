require 'test_helper'

class ProductoListaPrecioControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:producto_lista_precio)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producto_lista_precio" do
    assert_difference('ProductoListaPrecio.count') do
      post :create, :producto_lista_precio => { }
    end

    assert_redirected_to producto_lista_precio_path(assigns(:producto_lista_precio))
  end

  test "should show producto_lista_precio" do
    get :show, :id => producto_lista_precio(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => producto_lista_precio(:one).to_param
    assert_response :success
  end

  test "should update producto_lista_precio" do
    put :update, :id => producto_lista_precio(:one).to_param, :producto_lista_precio => { }
    assert_redirected_to producto_lista_precio_path(assigns(:producto_lista_precio))
  end

  test "should destroy producto_lista_precio" do
    assert_difference('ProductoListaPrecio.count', -1) do
      delete :destroy, :id => producto_lista_precio(:one).to_param
    end

    assert_redirected_to producto_lista_precio_path
  end
end
