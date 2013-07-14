require "rvm/capistrano"
require "bundler/capistrano"
require 'puma/capistrano'
require "capistrano_colors"
# require "capistrano/ext/multistage"

%w[base nodejs nginx assets check log callbacks].each do |recipe|
  load "config/recipes/#{recipe}"
end

# multistage
# set :stages, %w(production staging)
#
# RVM settings

# Servers and their roles.
server "rheia.us", :web, :app, :db, primary: true
set :server_name, "rheia.us"

# Server-side information.
set :user,        "deploy"
set :application, "south_loop_rsvp"
set :deploy_to,   "/home/#{user}/#{application}"
set :use_sudo,    false

# RVM settings
set :rvm_type, :user # user's rvm

# Repository (if any) configuration.
set :scm,         :git
set :deploy_via,  :remote_cache
set :repository,  "git@github.com:rutkovsky/south-loop-campus-rsvp.git"
set :branch,      "master"

# Run on Linux: `$ ssh-add` or on OSX: `$ ssh-add -K` for "forward_agent".
ssh_options[:forward_agent] = true
ssh_options[:port]          = 22
default_run_options[:pty]   = true



set :rvm_ruby_string, "2.0.0"# set :default_stage, "staging"

after 'deploy:create_symlink', "deploy:assets:precompile_locally"

# set :application, "south_loop_rsvp"
# set :repository,  "git@github.com:rutkovsky/south-loop-campus-rsvp.git"
# 
# set :user,        "deploy"
# set :deploy_to,   "/home/#{user}/#{application}"
# set :use_sudo,    false
# 
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# server "rheia.us", :web, :app, :db, primary: true
# # role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "rheia.us"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"
# 
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
