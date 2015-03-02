require 'test_helper'

class WriterRecordsControllerTest < ActionController::TestCase
  setup do
    @writer_record = writer_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:writer_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create writer_record" do
    assert_difference('WriterRecord.count') do
      post :create, writer_record: {  }
    end

    assert_redirected_to writer_record_path(assigns(:writer_record))
  end

  test "should show writer_record" do
    get :show, id: @writer_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @writer_record
    assert_response :success
  end

  test "should update writer_record" do
    patch :update, id: @writer_record, writer_record: {  }
    assert_redirected_to writer_record_path(assigns(:writer_record))
  end

  test "should destroy writer_record" do
    assert_difference('WriterRecord.count', -1) do
      delete :destroy, id: @writer_record
    end

    assert_redirected_to writer_records_path
  end
end
