require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'yaml'
require 'sequel'
require 'compass'
require 'sinatra/support/i18nsupport'

# def database_connect(database_name, username, password, database_type = 'postgres')
#   result = Sequel.connect(ENV["DATABASE_URL"] || 
#     "#{database_type}://#{username}:#{password}@localhost/#{database_name}")
#   result << "SET CLIENT_ENCODING TO 'UTF8';"
# end

Sinatra::Application.root = File.join(File.dirname(__FILE__),'..')

module Faqtly
  class App < Sinatra::Application    
    
    def self.env 
      ENV['RACK_ENV'] || 'development' 
    end 

    def self.root 
      File.expand_path(File.join(File.dirname(__FILE__),'..')) 
    end

    def self.config 
      config = YAML.load_file(File.join(root,'config','database.yml'))[env] 
      # I like to use logger to track queries 
      # config['logger'] = Logger.new(File.join(root,'log',"sequel_# 
# {env}.log")) 
      config 
    end

    def self.connect 
      Sequel.connect(config) 
    end 

  end 
end 

DB = Faqtly::App.connect unless Object.const_defined?('DB') 

require_relative "environments/#{ENV['RAILS_ENV'] || Sinatra::Base.environment}"
