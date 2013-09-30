# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "faqtly"
  s.version     = "1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ernesto Tagwerker"]
  s.email       = ["ernesto@ombushop.com"]
  s.homepage    = ""
  s.summary     = %q{FAQtly}
  s.description = %q{FAQtly: FAQ Open Source}

  s.rubyforge_project = "faqtly"

  s.add_dependency 'rake'
  s.add_dependency 'i18n'
  s.add_dependency 'httparty', '~> 0.8.1'
  s.add_dependency 'nokogiri', '~> 1.5.0'
  s.add_dependency 'chronic'
  s.add_dependency 'sinatra', '~> 1.2.3'
  s.add_dependency 'sinatra-support'
  s.add_dependency 'shotgun', '~> 0.9'
  s.add_dependency 'haml', '~> 3.1.4'
  s.add_dependency 'sequel'

  s.add_dependency 'thin'
  s.add_dependency 'i18n'

  # Sass & Compass
  s.add_dependency 'sass', '~> 3.1.12'
  s.add_dependency 'compass', '~> 0.12.0'
  s.add_dependency 'grid-coordinates', '~> 1.1.4'
  s.add_dependency 'rack-flash3'
  s.add_dependency 'sequel_pg'
  s.add_dependency 'pg', "~> 0.13.2"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'heroku'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'sqlite3'
end
