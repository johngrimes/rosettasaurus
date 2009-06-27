set :application, "rosettasaurus"
set :repository,  "git@github.com:johngrimes/rosettasaurus.git"
set :deploy_to, "/var/www/sites/rosettasaurus.com"
set :scm, "git"

set :user, "deploy"
set :runner, "deploy"

role :app, "67.23.31.183"
role :web, "67.23.31.183"
role :db,  "67.23.31.183", :primary => true

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, 'deploy:cleanup'

task :after_update_code, :roles => :app do
  run "ln -nfs #{shared_path}/db/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{shared_path}/config/environment.rb #{release_path}/config/environment.rb"

  run "ln -nfs #{shared_path}/sphinx/sphinx.development.conf #{release_path}/config/sphinx/sphinx.development.conf"
  run "ln -nfs #{shared_path}/sphinx/sphinx.test.conf #{release_path}/config/sphinx/sphinx.test.conf"
  run "ln -nfs #{shared_path}/sphinx/sphinx.production.conf #{release_path}/config/sphinx/sphinx.production.conf"

  sudo "chown -R deploy:www-data #{deploy_to}"
end

task :after_setup, :roles => [:app, :db, :web] do
  sudo "chown -R deploy:www-data #{deploy_to}"
end
