# -*- encoding : utf-8 -*-
require 'bundler/capistrano'

load 'deploy/assets'
set :normalize_asset_timestamps, false

set :stages, %w(staging production)
require 'capistrano/ext/multistage'
set :application, "politikaopen"

set(:deploy_to) { "/home/politikaopen/rails/#{application}/#{stage}" }

set :scm, :git
set :repository, "git://github.com/fairplaysk/politika_open.git"
set :use_sudo, false
set :branch, 'master'

set(:user) { Capistrano::CLI.ui.ask "user:" }
set :default_environment, { 'PATH' => "/usr/local/bin:/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
server "46.231.96.101", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/initializers/notification_mailing_list.rb #{release_path}/config/initializers/notification_mailing_list.rb"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
  end
end

before 'deploy:assets:precompile', 'deploy:symlink_shared'