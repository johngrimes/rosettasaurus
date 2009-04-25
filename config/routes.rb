ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource :session
  map.resources :translations
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  
  map.show_translation '/translations/:from_language.:to_language/:id',
    :controller => 'translations',
    :action => 'show'
  
  map.history '/translations/:id/history',
    :controller => 'translations',
    :action => 'history'
  
  map.new_searched_translation '/translations/new',
    :controller => 'translations',
    :action => 'new',
    :conditions => { :method => :post }
  
  map.search '/search',
    :controller => 'search',
    :action => 'search'
  
  # Help
  map.help "/help/:action",
    :controller => 'help'
  
  map.base '',
    :controller => 'search',
    :action => 'index'
  
  # Sitemap
  map.sitemap "/sitemap.xml",
    :controller => 'promo',
    :action => 'sitemap'
end
