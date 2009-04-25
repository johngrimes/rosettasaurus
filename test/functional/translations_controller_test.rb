require 'test_helper'

class TranslationsControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  fixtures :users
    
  def setup
    login_as :quentin
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:translations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create translation" do
    assert_difference('Translation.count', +1) do
      post :create, 
        :translation => { :from_sentence => random_string(250),
        :from_language_id => languages(:japanese).id,
        :to_sentence => random_string(250),
        :to_language_id => languages(:german).id }
    end    
    assert_response :redirect
  end

  test "should show translation" do
    get :show, 
      :id => translations(:one).id,
      :from_language => translations(:one).from_language.tag,
      :to_language => translations(:one).to_language.tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => translations(:one).id
    assert_response :success
  end

  test "should update translation" do
    put :update, :id => translations(:one).id, 
      :translation => { :from_sentence => random_string(250),
      :from_language_id => languages(:english).id,
      :to_sentence => random_string(250),
      :to_language_id => languages(:german).id,
      :comment => 'Spelling mistake.' }
    
    assert_redirected_to show_translation_url(:from_language => languages(:english).tag, 
      :to_language => languages(:german).tag, 
      :id => translations(:one).id)
  end
end
