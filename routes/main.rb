require 'base'
require 'static'
require 'admin'

# encoding: utf-8
module Faqtly
  class App < Sinatra::Application
    include Permalinker

    use Faqtly::Admin
    use Faqtly::Static
  end
end
