require 'sinatra/base'
require 'sinatra/flash'

module Faqtly
  class Base < Sinatra::Base
    set :views, Proc.new { File.join(root, "../views") }

    # I18n
    register Sinatra::I18nSupport
    set :default_locale, 'es'

    # We're going to load the paths to locale files
    I18n.load_path += Dir[File.join(Sinatra::Application.root, 'config', 'locales', '*.yml').to_s]
    load_locales Dir[File.join(Sinatra::Application.root, 'config', 'locales', '*.yml').to_s]
    I18n.enforce_available_locales = false
    # default_places { File.join(Sinatra::Application.root, 'locales') }

    # HTTP Authentication
    set sessions: true

    # HAML / SASS
    set :haml, {format: :html5, escape_html: true}
    set :scss, {style: :compact, debug_info: false}

    use Rack::MethodOverride
    register Sinatra::Flash

    helpers Rack::Utils
    helpers Haml::Util
    helpers Faqtly::Authentication
    helpers Faqtly::RenderPartial
    helpers Faqtly::SEO
    helpers TagsHelper
    helpers QuestionsHelper

  end
end
