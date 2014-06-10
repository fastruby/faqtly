require 'base'
require 'static'
require 'admin'

# encoding: utf-8
module Faqtly
  class App < Sinatra::Application
    include Permalinker

    use Admin
    use Static
  end
end
