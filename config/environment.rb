require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'sequel'
require 'compass'
require 'sinatra/support/i18nsupport'

def database_connect(database_name, username, password, database_type = 'postgres')
  result = Sequel.connect(ENV["DATABASE_URL"] || 
    "#{database_type}://#{username}:#{password}@localhost/#{database_name}")
  result << "SET CLIENT_ENCODING TO 'UTF8';"
end

Sinatra::Application.root = File.join(File.dirname(__FILE__),'..')

require_relative "environments/#{ENV['RAILS_ENV'] || Sinatra::Base.environment}"
