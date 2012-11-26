require_relative 'lib/permalinker'
require_relative 'config/environment'

class Faqtly < Sinatra::Application
  # HTTP Authentication
  set :sessions => true

  # HAML / SASS
  set :haml, {:format => :html5, :escape_html => true}
  set :scss, {:style => :compact, :debug_info => false}

  # I18n
  register Sinatra::I18nSupport
  load_locales File.join(Sinatra::Application.root, 'locales')

  set :default_locale, 'es'
  use Rack::MethodOverride

  configure :production, :development do
    enable :logging
    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, 'views'
    set :public_folder, 'public'
    set :haml, { format: :html5 } # default Haml format is :xhtml
    Compass.add_project_configuration(File.join(Sinatra::Application.root, 'compass.rb'))  
    enable :clean_trace
  end

  configure :test do
    set :root, File.dirname(__FILE__)
    set :views, "#{File.dirname(__FILE__)}/views"
  end

end

require_relative 'models/init'
require_relative 'helpers/init'
require_relative 'routes/main'