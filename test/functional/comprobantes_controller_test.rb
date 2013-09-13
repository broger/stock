require 'test_helper'

class ComprobantesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comprobantes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comprobante" do
    assert_difference('Comprobante.count') do
      post :create, :comprobante => { }
    end

    assert_redirected_to comprobante_path(assigns(:comprobante))
  end

  test "should show comprobante" do
    get :show, :id => comprobantes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => comprobantes(:one).to_param
    assert_response :success
  end

  test "should update comprobante" do
    put :update, :id => comprobantes(:one).to_param, :comprobante => { }
    assert_redirected_to comprobante_path(assigns(:comprobante))
  end

  test "should destroy comprobante" do
    assert_difference('Comprobante.count', -1) do
      delete :destroy, :id => comprobantes(:one).to_param
    end

    assert_redirected_to comprobantes_path
  end
end
