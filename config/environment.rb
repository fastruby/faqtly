require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'yaml'
require 'pg'
require 'sequel'
require 'sequel/adapters/postgres'
require 'sequel_pg'
require 'compass'
require 'sinatra/support/i18nsupport'

Sinatra::Application.root = File.join(File.dirname(__FILE__),'..')

module Faqtly
  class App < Sinatra::Application

    def self.env
      ENV['RACK_ENV'] || 'development'
    end

    def self.root
      @app_root ||= File.join(File.dirname(__FILE__), '..')
      @app_root
    end

    def self.config
      template = ERB.new(File.read(File.join(root,'config', 'database.yml'))).result
      database_config = YAML.load(template)
      database_config[env]
    end

    def self.connect
      hash = config
      url = "postgres://#{hash['username']}:"\
            "#{hash['password']}@#{hash['host']}:#{hash['port']}/"\
            "#{hash['database']}"
      Sequel.connect(url)
    end

  end
end

DB = Faqtly::App.connect unless Object.const_defined?('DB')
Sequel::Model.db = DB
DB.extension :pagination

require_relative "environments/#{ENV['RAILS_ENV'] || Sinatra::Base.environment}"
