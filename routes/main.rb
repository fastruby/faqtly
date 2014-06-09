require 'static'
require 'admin'

# encoding: utf-8
module Faqtly
  class App < Sinatra::Application
    include Permalinker
  end
end
