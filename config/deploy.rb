set :application, "rosettasaurus"
set :repository,  "svn://rosettasaurus.com/opt/svnserve/rosettasaurus/rosettasaurus/app"
set :deploy_to, "/home/webadmin/rosettasaurus.com"

set :user, "webadmin"
set :runner, "webadmin"

role :app, "rosettasaurus.com"
role :web, "rosettasaurus.com"
role :db,  "rosettasaurus.com", :primary => true

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, 'deploy:cleanup'

task :after_update_code, :roles => :app do
  run "ln -nfs #{shared_path}/system/db/database.yml #{release_path}/config/database.yml"
  sudo "chown -R webadmin:webadmin #{deploy_to}"
end

task :after_setup, :roles => [:app, :db, :web] do
  sudo "chown -R webadmin:webadmin #{deploy_to}"
end