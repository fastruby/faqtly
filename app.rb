require 'i18n'
require 'sequel'
require 'will_paginate'
require 'will_paginate/sequel'

require_relative 'lib/permalinker'
require_relative 'config/environment'
require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'routes/main'

# puts "Path to Compass: #{File.join(Faqtly::App.root, 'config', 'compass.rb').to_s}"

module Faqtly
  class App < Sinatra::Application

    configure :production, :development, :test do
      enable :logging
      set :app_file, __FILE__
      set :root, File.join(App.root)
      set :views, File.join(App.root, 'views')
      set :public_folder, File.join(App.root, 'public')
      set :haml, { format: :html5 } # default Haml format is :xhtml
      Compass.add_project_configuration(File.join(App.root, 'config', 'compass.rb'))
      enable :clean_trace
    end

    configure :production do
      set :show_exceptions, false
    end

  end
end
