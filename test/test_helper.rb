ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  fixtures :all

  def random_string(length)
    source_characters = "0124356789abcdefghijk" 
    random = "" 
    1.upto(length) { random += source_characters[rand(source_characters.length),1] }
    return random
  end
end
