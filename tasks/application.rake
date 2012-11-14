desc 'Start the application'
task :start do
  system "bundle exec shotgun config.ru"
end

task :environment do
  require './config/environment'
end

task :seed => :environment do
  require 'csv'    

  csv_text = File.read('db/seed/initial-faq-sheet.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    tag_name = row[0]
    question = row[1]
    answer = row[3]

    tag = Tag.where(name: tag_name).first
    tag = Tag.create(name: tag_name) unless tag

    q = Question.create(question: question, answer: answer)
    q.tags << tag
    q.save!
  end

end
