desc 'Start the application'
task :start do
  system "bundle exec shotgun config.ru"
end

task :environment do
  require './config/environment'
end

task seed: :environment do
  require 'csv'    
  require_relative '../lib/permalinker'
  require_relative '../models/question'
  require_relative '../models/tag'

  csv_text = File.read('db/seed/initial-faq-sheet.csv')
  csv = CSV.parse(csv_text, headers: true)
  csv.each do |row|
    tag_name = row[0]
    question = row[1]
    answer = row[2]
    description = row[3]
    keywords = row[4]
    unless answer.start_with? "<p>"
      answer = "<p>#{answer}</p>"
    end

    Tag.set_dataset :tags # needed to reload columns data
    tag = Tag.where(name: tag_name).first
    tag = Tag.new(name: tag_name).save unless tag
    
    Question.set_dataset :questions # need to reload columns data
    q = Question.new(question: question, answer: answer, 
                     description: description, keywords: keywords)
    q.save
    q.add_tag(tag)

  end

end
