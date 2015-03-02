require 'test_helper'

class StarRecordsControllerTest < ActionController::TestCase
  setup do
    @star_record = star_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:star_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create star_record" do
    assert_difference('StarRecord.count') do
      post :create, star_record: {  }
    end

    assert_redirected_to star_record_path(assigns(:star_record))
  end

  test "should show star_record" do
    get :show, id: @star_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @star_record
    assert_response :success
  end

  test "should update star_record" do
    patch :update, id: @star_record, star_record: {  }
    assert_redirected_to star_record_path(assigns(:star_record))
  end

  test "should destroy star_record" do
    assert_difference('StarRecord.count', -1) do
      delete :destroy, id: @star_record
    end

    assert_redirected_to star_records_path
  end
end
