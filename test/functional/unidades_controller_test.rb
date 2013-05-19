require 'test_helper'

class UnidadesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unidad" do
    assert_difference('Unidad.count') do
      post :create, :unidad => { }
    end

    assert_redirected_to unidad_path(assigns(:unidad))
  end

  test "should show unidad" do
    get :show, :id => unidades(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => unidades(:one).to_param
    assert_response :success
  end

  test "should update unidad" do
    put :update, :id => unidades(:one).to_param, :unidad => { }
    assert_redirected_to unidad_path(assigns(:unidad))
  end

  test "should destroy unidad" do
    assert_difference('Unidad.count', -1) do
      delete :destroy, :id => unidades(:one).to_param
    end

    assert_redirected_to unidades_path
  end
end
