class PromoController < ApplicationController
  def sitemap
    @translations = Translation.find(:all)
    render :template => 'promo/sitemap.rxml', :layout => false
  end
end
