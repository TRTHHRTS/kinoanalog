require 'test_helper'

class MainsControllerTest < ActionController::TestCase
  setup do
    @main = mains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create main" do
    assert_difference('Main.count') do
      post :create, main: {  }
    end

    assert_redirected_to main_path(assigns(:main))
  end

  test "should show main" do
    get :show, id: @main
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @main
    assert_response :success
  end

  test "should update main" do
    patch :update, id: @main, main: {  }
    assert_redirected_to main_path(assigns(:main))
  end

  test "should destroy main" do
    assert_difference('Main.count', -1) do
      delete :destroy, id: @main
    end

    assert_redirected_to mains_path
  end
end
