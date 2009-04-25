namespace :rosettasaurus do
  desc "Reindex Sphinx translation search index"
  task :reindex_search => :environment do
    if RAILS_ENV == 'production' 
      system "sudo /usr/local/bin/indexer --all --rotate --config #{RAILS_ROOT}/config/sphinx/sphinx.#{RAILS_ENV}.conf"
    else
      system "indexer --all --rotate --config #{RAILS_ROOT}/config/sphinx/sphinx.#{RAILS_ENV}.conf"
    end
  end
end