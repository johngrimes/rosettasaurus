class SearchController < ApplicationController
  layout 'standard'
  
  def index
    @languages = Language.find(:all).collect {|l| [ l.description, l.tag ] }
  end

  def search
    @query = params[:query]
    @from_language = Language.find_by_tag(params[:language][:from])
    @to_language = Language.find_by_tag(params[:language][:to])
    if @exact = Translation.find_exact(@from_language.id, @to_language.id, @query)
      redirect_to show_translation_url(:from_language => @from_language.tag, :to_language => @to_language.tag, :id => @exact.id)
    else
      @new_translation = Translation.new
      @new_translation.from_sentence = @query
      @new_translation.from_language = @from_language
      @new_translation.to_language = @to_language
      @similar = Translation.find_similar(@from_language.id, @to_language.id, @query)
    end
  end
end
