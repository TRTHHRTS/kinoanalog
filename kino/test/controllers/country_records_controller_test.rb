require 'test_helper'

class CountryRecordsControllerTest < ActionController::TestCase
  setup do
    @country_record = country_records(:one)
  end

  test "should get details" do
    get :details
    assert_response :success
    assert_not_nil assigns(:country_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create country_record" do
    assert_difference('CountriesMovies.count') do
      post :create, country_record: {  }
    end

    assert_redirected_to country_record_path(assigns(:country_record))
  end

  test "should show country_record" do
    get :show, id: @country_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @country_record
    assert_response :success
  end

  test "should update country_record" do
    patch :update, id: @country_record, country_record: {  }
    assert_redirected_to country_record_path(assigns(:country_record))
  end

  test "should destroy country_record" do
    assert_difference('CountriesMovies.count', -1) do
      delete :destroy, id: @country_record
    end

    assert_redirected_to country_records_path
  end
end
