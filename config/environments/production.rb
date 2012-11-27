puts "Loading production environment"

url = ENV['DATABASE_URL'] || "postgres://postgres:0mbu@localhost/faqtly"

Sequel.connect(url)
