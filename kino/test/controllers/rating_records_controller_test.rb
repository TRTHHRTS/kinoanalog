require 'test_helper'

class RatingRecordsControllerTest < ActionController::TestCase
  setup do
    @rating_record = rating_records(:one)
  end

  test "should get details" do
    get :details
    assert_response :success
    assert_not_nil assigns(:rating_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rating_record" do
    assert_difference('RatingRecord.count') do
      post :create, rating_record: {  }
    end

    assert_redirected_to rating_record_path(assigns(:rating_record))
  end

  test "should show rating_record" do
    get :show, id: @rating_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rating_record
    assert_response :success
  end

  test "should update rating_record" do
    patch :update, id: @rating_record, rating_record: {  }
    assert_redirected_to rating_record_path(assigns(:rating_record))
  end

  test "should destroy rating_record" do
    assert_difference('RatingRecord.count', -1) do
      delete :destroy, id: @rating_record
    end

    assert_redirected_to rating_records_path
  end
end
