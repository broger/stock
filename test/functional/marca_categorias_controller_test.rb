require 'test_helper'

class MarcaCategoriasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marca_categorias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marca_categoria" do
    assert_difference('MarcaCategoria.count') do
      post :create, :marca_categoria => { }
    end

    assert_redirected_to marca_categoria_path(assigns(:marca_categoria))
  end

  test "should show marca_categoria" do
    get :show, :id => marca_categorias(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => marca_categorias(:one).to_param
    assert_response :success
  end

  test "should update marca_categoria" do
    put :update, :id => marca_categorias(:one).to_param, :marca_categoria => { }
    assert_redirected_to marca_categoria_path(assigns(:marca_categoria))
  end

  test "should destroy marca_categoria" do
    assert_difference('MarcaCategoria.count', -1) do
      delete :destroy, :id => marca_categorias(:one).to_param
    end

    assert_redirected_to marca_categorias_path
  end
end
