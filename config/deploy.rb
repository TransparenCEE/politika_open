# -*- encoding : utf-8 -*-
# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"

require 'bundler/capistrano'

set :rvm_ruby_string, '1.9.2'

set :stages, %w(staging production)
require 'capistrano/ext/multistage'
set :application, "politikaopen_capistrano"

set(:deploy_to) { "/var/www/projects/#{application}/#{stage}" }

set :scm, :git
set :repository, "git://github.com/fairplaysk/politika_open.git"
set :use_sudo, false
set :branch, 'master'

set(:user) { Capistrano::CLI.ui.ask "user:" }
server "195.210.28.155", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/initializers/mongoid_config.rb #{release_path}/config/initializers/mongoid_config.rb"
    run "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'