require 'test_helper'

class TermsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get open" do
    get :open
    assert_response :success
  end

  test "should get close" do
    get :close
    assert_response :success
  end

end
