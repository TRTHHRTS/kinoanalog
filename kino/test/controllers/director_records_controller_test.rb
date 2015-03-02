require 'test_helper'

class DirectorRecordsControllerTest < ActionController::TestCase
  setup do
    @director_record = director_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:director_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create director_record" do
    assert_difference('DirectorRecord.count') do
      post :create, director_record: {  }
    end

    assert_redirected_to director_record_path(assigns(:director_record))
  end

  test "should show director_record" do
    get :show, id: @director_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @director_record
    assert_response :success
  end

  test "should update director_record" do
    patch :update, id: @director_record, director_record: {  }
    assert_redirected_to director_record_path(assigns(:director_record))
  end

  test "should destroy director_record" do
    assert_difference('DirectorRecord.count', -1) do
      delete :destroy, id: @director_record
    end

    assert_redirected_to director_records_path
  end
end
