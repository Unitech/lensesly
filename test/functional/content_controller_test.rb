require 'test_helper'

class ContentControllerTest < ActionController::TestCase
  test "should get opticians" do
    get :opticians
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get mention" do
    get :mention
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get conditions" do
    get :conditions
    assert_response :success
  end

end
