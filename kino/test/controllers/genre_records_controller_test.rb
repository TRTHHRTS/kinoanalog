require 'test_helper'

class GenreRecordsControllerTest < ActionController::TestCase
  setup do
    @genre_record = genre_records(:one)
  end

  test "should get details" do
    get :details
    assert_response :success
    assert_not_nil assigns(:genre_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genre_record" do
    assert_difference('GenreRecord.count') do
      post :create, genre_record: {  }
    end

    assert_redirected_to genre_record_path(assigns(:genre_record))
  end

  test "should show genre_record" do
    get :show, id: @genre_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @genre_record
    assert_response :success
  end

  test "should update genre_record" do
    patch :update, id: @genre_record, genre_record: {  }
    assert_redirected_to genre_record_path(assigns(:genre_record))
  end

  test "should destroy genre_record" do
    assert_difference('GenreRecord.count', -1) do
      delete :destroy, id: @genre_record
    end

    assert_redirected_to genre_records_path
  end
end
