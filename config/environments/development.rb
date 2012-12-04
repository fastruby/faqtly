puts "Loading development"

url = ENV['DATABASE_URL'] || "postgres://postgres@localhost/faqtly_development"

Sequel.connect(url)
