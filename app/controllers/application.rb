class ApplicationController < ActionController::Base
  include AuthenticatedSystem, ExceptionNotifiable
  
  helper :all
  protect_from_forgery # :secret => '2b3f54678e44a69d6a25e73b3d26e883'
  
  def local_request?
    false
  end
end
