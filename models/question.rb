# encoding: utf-8
class Question < Sequel::Model
  include Permalinker
  dataset.extension(:pagination)

  self.raise_on_save_failure = false

  plugin :validation_helpers
  many_to_many :tags

  def validate
    super
    validates_presence [:question, :answer]
    validates_unique [:question]
  end

  # Finds a set of [Question] instances with the query.
  # It searches through question and answer content.
  #
  # @return [Array]
  def self.full_text_search(query, params = {})
    dataset = Question.where(Sequel.like(:answer, "%#{query}%")).
                  or(Sequel.like(:question, "%#{query}%"))

    paginated(params.merge(dataset: dataset))
    # TODO full_text_search('answer', query)
  end

  # Finds a [Question] using the permalink
  #
  # @return [Question,nil]
  def self.find_by_permalink(permalink)
    Question.where(permalink: permalink).first
  end

  def self.paginated(params = {})
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    unless dataset = params[:dataset]
      scope = params[:scope] || Question
      dataset = scope.dataset
    end

    dataset.paginate(page.to_i, per_page.to_i)
  end

  private

  # Updates the permalink using [Permalinker]
  def before_validation
    self.permalink = generate_permalink(self.question)
  end
end
