require 'test_helper'

class TipoComprobantesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_comprobantes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_comprobante" do
    assert_difference('TipoComprobante.count') do
      post :create, :tipo_comprobante => { }
    end

    assert_redirected_to tipo_comprobante_path(assigns(:tipo_comprobante))
  end

  test "should show tipo_comprobante" do
    get :show, :id => tipo_comprobantes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tipo_comprobantes(:one).to_param
    assert_response :success
  end

  test "should update tipo_comprobante" do
    put :update, :id => tipo_comprobantes(:one).to_param, :tipo_comprobante => { }
    assert_redirected_to tipo_comprobante_path(assigns(:tipo_comprobante))
  end

  test "should destroy tipo_comprobante" do
    assert_difference('TipoComprobante.count', -1) do
      delete :destroy, :id => tipo_comprobantes(:one).to_param
    end

    assert_redirected_to tipo_comprobantes_path
  end
end
