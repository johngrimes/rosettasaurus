require 'riddle.rb'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'

class Translation < ActiveRecord::Base
  include AuthenticatedSystem
  
  belongs_to :from_language,
    :class_name => 'Language',
    :foreign_key => 'from_language_id'
  belongs_to :to_language,
    :class_name => 'Language',
    :foreign_key => 'to_language_id'
  belongs_to :opposite,
    :class_name => 'Translation',
    :foreign_key => 'opposite_id'
  has_many :edits
  
  validates_presence_of :from_sentence, :from_language, :to_sentence, :to_language
  validates_length_of :from_sentence, :maximum => 1000
  validates_length_of :to_sentence, :maximum => 1000
  
  after_commit :reindex_search
  
  def store_edit(user, comment)
    edit = Edit.new
    edit.translation_id = id
    edit.user_id = user.id
    edit.from_sentence = from_sentence
    edit.from_language_id = from_language_id
    edit.to_sentence = to_sentence
    edit.to_language_id = to_language_id
    edit.edited_at = updated_at ? updated_at : created_at
    edit.comment = comment
    edit.save!
  end
  
  def reindex_search
    Rake::Task['rosettasaurus:reindex_search'].execute
  end
  
  def from_sentence=(new_from_sentence)
    write_attribute :from_sentence, new_from_sentence.gsub(/[\n\r\t]/, '')
  end
  
  def to_sentence=(new_to_sentence)
    write_attribute :to_sentence, new_to_sentence.gsub(/[\n\r\t]/, '')
  end
  
  def sentence(language_id)
    if from_language_id == language_id
      from_sentence
    elsif to_language_id == language_id
      to_sentence
    else
      nil
    end
  end
  
  def self.find_exact(from_language, to_language, query)
    translations = find(:all, 
      :conditions => { :from_language_id => from_language, 
        :to_language_id => to_language,
        :from_sentence => query })
    
    if translations.length > 0
      return translations.first
    else
      opposite_translations = find(:all, 
        :conditions => { :from_language_id => to_language, 
          :to_language_id => from_language,
          :to_sentence => query })
      if opposite_translations.length > 0
        return opposite_translations.first
      else
        return nil
      end
    end
  end
  
  def self.find_similar(from_language, to_language, query)
    logger.info "Sphinx similar query: from_language=#{from_language}, to_language=#{to_language}, query=#{query.mb_chars}"
    search_client = Riddle::Client.new $SPHINX_HOST, $SPHINX_PORT
    search_client.match_mode = :any
    search_client.filters << Riddle::Client::Filter.new('from_language_id', [from_language], false)
    search_client.filters << Riddle::Client::Filter.new('to_language_id', [to_language], false)
    result = search_client.query query
    logger.info "Sphinx result: #{result.to_json}"
    translations = []
    result[:matches].each do |match|
      translations << Translation.find(match[:attributes]['translation_id'])
    end
    return translations
  end
end
