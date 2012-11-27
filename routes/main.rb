require_relative 'admin'
require_relative 'static'

# encoding: utf-8
module Faqtly 
  class App < Sinatra::Application
    include Permalinker
    extend Routes::Admin
    extend Routes::Static
  end
end