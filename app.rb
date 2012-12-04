require 'rack-flash'
require 'i18n'

require_relative 'lib/permalinker'
require_relative 'config/environment'
require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'routes/main'

module Faqtly
  class App < Sinatra::Application

    # HTTP Authentication
    set :sessions => true

    # HAML / SASS
    set :haml, {:format => :html5, :escape_html => true}
    set :scss, {:style => :compact, :debug_info => false}

    # I18n
    register Sinatra::I18nSupport


    # We're going to load the paths to locale files,
    I18n.load_path += Dir[File.join(File.dirname(Sinatra::Application.root), 'config', 'locales', '*.yml').to_s]
    load_locales Dir[File.join(File.dirname(Sinatra::Application.root), 'config', 'locales', '*.yml').to_s]
    # default_places { File.join(Sinatra::Application.root, 'locales') }
    
    set :default_locale, 'es'
    use Rack::MethodOverride
    use Rack::Flash, :sweep => true

    helpers Rack::Utils
    helpers Faqtly::Authentication
    helpers Faqtly::RenderPartial
    helpers TagsHelper
    helpers QuestionsHelper

    configure :production, :development do
      enable :logging
      set :app_file, __FILE__
      set :root, File.join(Sinatra::Application.root, '..')
      set :views, File.join(Sinatra::Application.root, '..', 'views')
      set :public_folder, File.join(Sinatra::Application.root, '..', 'public')
      set :haml, { format: :html5 } # default Haml format is :xhtml
      Compass.add_project_configuration(File.join(Sinatra::Application.root, 'compass.rb'))  
      enable :clean_trace
    end

    configure :test do
      set :root, File.dirname(__FILE__)
      set :views, "#{File.dirname(__FILE__)}/views"
    end

  end
end
