require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  fixtures :translations, :languages
  
  test "from language link" do
    expected_result = languages(:english)
    assert translations(:one).from_language == expected_result
  end
  
  test "to language link" do
    expected_result = languages(:german)
    assert translations(:one).to_language == expected_result
  end
  
  test "should reject no from sentence" do
    assert_no_difference 'Translation.count' do      
      translation = Translation.new
      translation.from_language = languages(:japanese)
      translation.save
    end
  end
  
  test "should reject no from language" do
    assert_no_difference 'Translation.count' do
      translation = Translation.new
      translation.from_sentence = random_string(100)
      translation.save
    end
  end
  
  test "should reject long from sentence" do
    assert_no_difference 'Translation.count' do      
      translation = Translation.new
      translation.from_sentence = random_string(1001)
      translation.from_language = languages(:japanese)
      translation.to_sentence = 'Hello my friends!'
      translation.to_language = languages(:english)
      translation.save
    end
  end
  
  test "should reject long to sentence" do
    assert_no_difference 'Translation.count' do      
      translation = Translation.new
      translation.from_sentence = 'Hello my friends!'
      translation.from_language = languages(:english)
      translation.to_sentence = random_string(1001)
      translation.to_language = languages(:japanese)
      translation.save
    end
  end
  
  test "should find exact query" do
    expected_result = translations(:three)
    assert Translation.find_exact(3, 1, '私はビールをくれ！') == expected_result
  end
  
  test "should find similar query with no errors" do
    Translation.find_similar(1, 2, random_string(250))
  end
  
  test "should filter illegal charactes from from_sentence" do
    translation = Translation.new
    translation.from_sentence = "Hello\n my \tfriends!\r"
    translation.from_language = languages(:japanese)
    translation.to_sentence = 'Hello my friends!'
    translation.to_language = languages(:english)
    translation.save
    assert translation.from_sentence == 'Hello my friends!'
  end
  
  test "should filter illegal charactes from to_sentence" do
    translation = Translation.new
    translation.from_sentence = 'Hello my friends!'
    translation.from_language = languages(:japanese)
    translation.to_sentence = "Hello\n my \tfriends!\r"
    translation.to_language = languages(:english)
    translation.save
    assert translation.to_sentence == 'Hello my friends!'
  end
end
