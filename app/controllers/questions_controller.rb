class QuestionsController < ApplicationController
  before_action :find_test, only: %i(index new create)
  before_action :find_question, only: %i(show)

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found
  rescue_from SQLite3::ConstraintException, with: :rescue_with_unique_failed

  def index
    questions = @test.questions
    title = "Список вопросов теста #{@test.title} с уровнем сложности #{@test.level}"
    questions_titles = questions.map(&:body)

    respond_to do |format|
      format.text { render plain: text_for_questions_plain(title, questions_titles) }
      format.html { render html: text_for_questions_html(title, questions).html_safe, layout: "application" }
    end
  end

  def show
    respond_to do |format|
      format.text { render plain: "#{@question.body}" }
      format.html { render html: "<h1>#{@question.body}</h1>".html_safe, layout: "application" }
    end
  end

  def new
  end

  def create
    @test.questions.create(question_params)
  end

  def destroy
    Question.delete(params[:id])
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def text_for_questions_plain(title, questions_titles)
    return "#{title}:\n\n" + questions_titles.join(",\n")
  end

  def text_for_questions_html(title, questions)
    questions_html = ""
    questions.each do |question|
      questions_html += "<li>#{question.body}</li>"
    end

    return "<h1>#{title}</h1>" +
      "<ul class='mb'>" +
      questions_html +
      "</ul>"
  end

  def rescue_with_test_not_found
    respond_to do |format|
      format.text { render plain: "404 - Запрашиваемая страница не найдена." }
      format.html { render html: "<h1>404 - Запрашиваемая страница не найдена.</h1>".html_safe }
    end
  end

  def rescue_with_unique_failed
    respond_to do |format|
      format.text { render plain: "Такой вопрос уже существует в этом тесте" }
      format.html { render html: "<h1>Такой вопрос уже существует в этом тесте</h1>".html_safe }
    end
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
