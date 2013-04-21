require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)
require 'sinatra'
require 'capybara'
require 'capybara/dsl'
require 'test/unit'
require 'database_cleaner'

# Set test environment
ENV['RACK_ENV'] = 'test'
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

require_relative '../app'

# Making Capybara::DSL available to all test cases
class Test::Unit::TestCase
  include Capybara::DSL

  def setup
    Capybara.app = Faqtly::App.new
    DatabaseCleaner.strategy = :truncation
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
    DatabaseCleaner.clean
  end

  protected

    # Asserts that the SEO for the page is proper
    def assert_seo
      within('head') do
        assert meta_tag('description')[:content], "No description meta tag for #{page.current_path}"
        assert meta_tag('keywords')[:content], "No keywords meta tag for #{page.current_path}"
      end
    end

    # Returns the meta with the name parameter
    #
    # @param [String] eg. 'description'
    def meta_tag(name)
      page.first(:xpath, "//meta[@name=\"#{name}\"]")
    end

    # AKA assert_false
    def deny(test, msg=nil)
      if msg then
        assert !test, msg
      else
        assert !test
      end
    end

    # HTTP Authentication
    def authorize_user!
      page.driver.browser.authorize('admin', 'ch0p')
    end

    # Submit POST request
    def post(path, data = {})
      page.driver.submit :post, path, data
    end

    # Submit PUT request
    def put(path, data = {})
      page.driver.submit :put, path, data
    end

    # Submit DELETE request
    def delete(path, data = {})
      page.driver.submit :delete, path, data
    end

end

puts "Testing #{Sinatra::Base.environment} environment"