require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  binding.pry
end

desc "bundle && migrate && seed"
task :setup do 
    sh "bundle"
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
end