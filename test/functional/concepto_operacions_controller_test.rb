require 'test_helper'

class ConceptoOperacionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:concepto_operacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create concepto_operacion" do
    assert_difference('ConceptoOperacion.count') do
      post :create, :concepto_operacion => { }
    end

    assert_redirected_to concepto_operacion_path(assigns(:concepto_operacion))
  end

  test "should show concepto_operacion" do
    get :show, :id => concepto_operacions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => concepto_operacions(:one).to_param
    assert_response :success
  end

  test "should update concepto_operacion" do
    put :update, :id => concepto_operacions(:one).to_param, :concepto_operacion => { }
    assert_redirected_to concepto_operacion_path(assigns(:concepto_operacion))
  end

  test "should destroy concepto_operacion" do
    assert_difference('ConceptoOperacion.count', -1) do
      delete :destroy, :id => concepto_operacions(:one).to_param
    end

    assert_redirected_to concepto_operacions_path
  end
end
