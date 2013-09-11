require 'test_helper'

class ListaPreciosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lista_precios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lista_precio" do
    assert_difference('ListaPrecio.count') do
      post :create, :lista_precio => { }
    end

    assert_redirected_to lista_precio_path(assigns(:lista_precio))
  end

  test "should show lista_precio" do
    get :show, :id => lista_precios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => lista_precios(:one).to_param
    assert_response :success
  end

  test "should update lista_precio" do
    put :update, :id => lista_precios(:one).to_param, :lista_precio => { }
    assert_redirected_to lista_precio_path(assigns(:lista_precio))
  end

  test "should destroy lista_precio" do
    assert_difference('ListaPrecio.count', -1) do
      delete :destroy, :id => lista_precios(:one).to_param
    end

    assert_redirected_to lista_precios_path
  end
end
