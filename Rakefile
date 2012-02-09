#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Focus::Application.load_tasks

namespace :focus do
  desc "Start www for development"
  task :start_www do
    system "bundle exec rails s"
  end

  desc "Start sync for development"
  task :start_sync do
  	system "cd mobwrite && ./daemon/mobwrite_daemon.py"
  end
end

desc "Start everything."
multitask :start => ['focus:start_www', 'focus:start_sync']
