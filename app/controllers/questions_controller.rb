class QuestionsController < ApplicationController
  before_action :find_test, only: %i(index new create)
  before_action :find_question, only: %i(show destroy)

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found
  rescue_from SQLite3::ConstraintException, with: :rescue_with_unique_failed

  def index
    questions = @test.questions
    title = "Список вопросов теста #{@test.title} с уровнем сложности #{@test.level}"
    questions_titles = questions.map(&:body)

    render html: text_for_questions_html(title, questions).html_safe, layout: "application"
  end

  def show
    render html: "<h1>#{@question.body}</h1>".html_safe, layout: "application"
  end

  def new
  end

  def create
    question = @test.questions.new(question_params)
    if question.save
      render html:"<h1>Вопрос успешно создан</h1>".html_safe
    else
      errors_messages = ""
      question.errors.each do |error|
        errors_messages << "<p>#{error.full_message}</p>"
      end
      render html:"<h1>Вопрос не был создан</h1><h2>Ошибка валидации</h2><div>#{errors_messages}</div>".html_safe
    end
  end

  def destroy
    @question.delete
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def text_for_questions_html(title, questions)
    questions_html = ""
    questions.each do |question|
      questions_html += "<li>#{question.body}</li>"
    end

    return "<h1>#{title}</h1>" +
      "<ol class='mb'>" +
      questions_html +
      "</ol>"
  end

  def rescue_with_test_not_found
    render html: "<h1>404 - Запрашиваемая страница не найдена.</h1>".html_safe
  end

  def rescue_with_unique_failed
    render html: "<h1>Такой вопрос уже существует в этом тесте</h1>".html_safe
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
