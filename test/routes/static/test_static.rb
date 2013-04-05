require 'test_helper'

class TestMain < Test::Unit::TestCase

  def test_root
    visit '/'
    assert_equal 200, page.status_code
    assert_seo
  end

  def test_about_page
    visit '/about'
    assert_equal 200, page.status_code
  end

  def test_questions_new_for_unauthorized_user
    visit '/questions/new'
    assert_equal 401, page.status_code
  end

  def test_questions_search
    @question = Question.create( question: 'Y candela? Y la moto?',
                      answer: 'alot' )

    visit "/preguntas/search?q=candela"
    assert_equal 200, page.status_code
    assert page.has_content?("la moto")
  end  

  def test_question_show
    @question = Question.create( question: 'What would Steve Jobs do?',
                      answer: 'He would probably Stay hungry Stay foolish.' )

    visit "/preguntas/#{@question.permalink}"
    assert_equal 200, page.status_code
    assert page.has_content?('Steve Jobs')
  end
end