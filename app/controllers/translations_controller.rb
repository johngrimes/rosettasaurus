class TranslationsController < ApplicationController
  layout 'standard'
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]
  
  # GET /translations
  def index
    @translations = Translation.find(:all)
  end

  # GET /translations/1
  def show
    @translation = Translation.find(params[:id])
    @from_language = Language.find_by_tag(params[:from_language])
    @to_language = Language.find_by_tag(params[:to_language])
    logger.info @translation.from_sentence.hex_values.to_json
    logger.info @translation.to_sentence.hex_values.to_json
    logger.info "Später bis.".hex_values.to_json
  end

  # GET /translations/new
  # POST /translations/new (for new translation based on a search)
  def new
    @translation = params[:translation] ? Translation.new(params[:translation]) : Translation.new
    @languages = Language.find(:all).collect {|l| [ l.description, l.id ] }
  end

  # GET /translations/1/edit
  def edit
    @translation = Translation.find(params[:id])
  end

  # POST /translations
  def create
    @translation = Translation.new(params[:translation])    
    @languages = Language.find(:all).collect {|l| [ l.description, l.id ] }

    if @translation.save!
      @translation.store_edit(current_user, 'Created')
      
      flash[:notice] = 'Translation was successfully created.'
      redirect_to show_translation_url(:from_language => @translation.from_language.tag, 
        :to_language => @translation.to_language.tag, 
        :id => @translation.id)
    else
      render :action => 'new'
    end
  end

  # PUT /translations/1
  def update
    @translation = Translation.find(params[:id])
    @comment = params[:comment]
    params[:translation].delete('comment')
    
    if @translation.update_attributes(params[:translation])
      @translation.store_edit(current_user, @comment)
      flash[:notice] = 'Translation was successfully updated.'
      redirect_to show_translation_url(:from_language => @translation.from_language.tag, :to_language => @translation.to_language.tag, :id => @translation.id)
    else
      render :action => 'edit'
    end
  end
  
  # GET /translations/1/history
  def history
    @translation = Translation.find(params[:id])
  end
  
  protected
  
  def store_edit(translation, comment)
    edit = Edit.new
    edit.translation_id = translation.id
    edit.user_id = current_user.id
    edit.from_sentence = translation.from_sentence
    edit.from_language_id = translation.from_language_id
    edit.to_sentence = translation.to_sentence
    edit.to_language_id = translation.to_language_id
    edit.edited_at = translation.updated_at ? translation.updated_at : translation.created_at
    edit.comment = comment
    edit.save!
  end
end
