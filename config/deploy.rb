
require 'bundler/capistrano'

set :application, "lensesly"

# Must change
set :user, 'root'
set :domain, '88.191.223.108'
set :applicationdir, "/var/www/#{application}"

set :scm, :git
set :repository,  "git@github.com:Alexandre-Strzelewicz/lensesly.git"
set :branch, :master
set :scm_verbose, true

set :bundle_cmd, "LANG='en_US.UTF-8' bundle"

role :web, domain
role :app, domain
role :db, domain, :primary => true

set :deploy_to, applicationdir

set :deploy_via, :checkout

# Remove some warning for asset pipeline
set :normalize_asset_timestamps, false

# Add RVM's lib directory to the load path
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require "rvm/capistrano"
#require "bundler/capistrano"

# Set ruby version for rvm
#set :rvm_ruby_string, '1.9.2-p290'

after "deploy:update_code", "deploy:migrate", "deploy:pipeline_precompile", "deploy:stop", "deploy:start"

namespace :deploy do

  desc "Start thin"
  task :start do
    run "cd #{release_path}; bundle exec thin start -C config/thin.yml"
  end
  
  task :stop do
    run "cd #{release_path}; bundle exec thin stop -C config/thin.yml"
  end

  task :migrate do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake db:migrate"
  end

  task :pipeline_precompile do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile --trace"
  end

  task :set_rights do 
    run "cd #{applicationdir}/current; chown -R www-data .; mkdir public/system; chmod -R 655 public/system "
  end

end

