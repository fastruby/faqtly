puts "Loading staging environment"

url = ENV['DATABASE_URL'] || "postgres://postgres@localhost/faqtly_production"

Sequel.connect(url)
