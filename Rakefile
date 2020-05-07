require_relative 'config/environment'
require 'sinatra/activerecord/rake'
# require 'active_record'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = nil
  Pry.start
end
