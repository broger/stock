require 'test_helper'

class MarcasRubrosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marcas_rubros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marcas_rubro" do
    assert_difference('MarcasRubro.count') do
      post :create, :marcas_rubro => { }
    end

    assert_redirected_to marcas_rubro_path(assigns(:marcas_rubro))
  end

  test "should show marcas_rubro" do
    get :show, :id => marcas_rubros(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => marcas_rubros(:one).to_param
    assert_response :success
  end

  test "should update marcas_rubro" do
    put :update, :id => marcas_rubros(:one).to_param, :marcas_rubro => { }
    assert_redirected_to marcas_rubro_path(assigns(:marcas_rubro))
  end

  test "should destroy marcas_rubro" do
    assert_difference('MarcasRubro.count', -1) do
      delete :destroy, :id => marcas_rubros(:one).to_param
    end

    assert_redirected_to marcas_rubros_path
  end
end
