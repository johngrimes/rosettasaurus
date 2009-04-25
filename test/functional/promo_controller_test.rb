require 'test_helper'

class PromoControllerTest < ActionController::TestCase
  test 'should get sitemap' do
    get :sitemap
    assert_response :success
  end
end
