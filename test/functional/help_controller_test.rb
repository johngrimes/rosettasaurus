require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test 'should get activation' do
    get :activation
    assert_response :success
  end
  
  test 'should get what_is_this' do
    get :what_is_this
    assert_response :success
  end
end
