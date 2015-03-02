require 'test_helper'

class ProducerRecordsControllerTest < ActionController::TestCase
  setup do
    @producer_record = producer_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:producer_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producer_record" do
    assert_difference('ProducerRecord.count') do
      post :create, producer_record: {  }
    end

    assert_redirected_to producer_record_path(assigns(:producer_record))
  end

  test "should show producer_record" do
    get :show, id: @producer_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @producer_record
    assert_response :success
  end

  test "should update producer_record" do
    patch :update, id: @producer_record, producer_record: {  }
    assert_redirected_to producer_record_path(assigns(:producer_record))
  end

  test "should destroy producer_record" do
    assert_difference('ProducerRecord.count', -1) do
      delete :destroy, id: @producer_record
    end

    assert_redirected_to producer_records_path
  end
end
