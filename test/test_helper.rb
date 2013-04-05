require 'rubygems'
require 'bundler'
require 'pry'
Bundler.setup(:default, :test)
require 'sinatra'
require 'capybara'
require 'capybara/dsl'
require 'test/unit'
require 'sequel_test_case'

require_relative '../app'

ENV['RACK_ENV'] = 'test'

# Making Capybara::DSL available to all test cases
class Test::Unit::TestCase
  include Capybara::DSL

  def setup
    Capybara.app = Faqtly::App.new
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

puts "Testing #{Sinatra::Base.environment} environment"

require File.join(File.dirname(__FILE__), '../app')

def deny(test, msg=nil)
  if msg then
    assert !test, msg
  else
    assert !test
  end
end

def assert_seo
  page
end

def authorize_user!
  page.driver.browser.authorize('admin', 'ch0p')
end

def post(path, data = {})
  page.driver.submit :post, path, data
end

def put(path, data = {})
  page.driver.submit :put, path, data
end
