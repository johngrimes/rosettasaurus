require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  fixtures :languages, :translations
  
  test 'should get index' do
    get :index
    assert_response :success
  end
  
  test 'should post exact search' do
    post :search,
      :query => 'Give me some beer!',
      :language => { :from => languages(:english).tag,
      :to => languages(:german).tag }
    
    assert_redirected_to show_translation_url(:from_language => languages(:english).tag, 
      :to_language => languages(:german).tag, 
      :id => translations(:one).id)
  end
  
  test 'should post similar search' do
    post :search,
      :query => random_string(250),
      :language => { :from => languages(:english).tag,
      :to => languages(:japanese).tag }
    assert_response :success
  end
end
