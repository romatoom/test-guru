class QuestionsController < ApplicationController
  before_action :find_test, only: %i(new create)
  before_action :find_question, only: %i(show edit update destroy)

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found
  rescue_from SQLite3::ConstraintException, with: :rescue_with_constraint_error

  def show
  end

  def new
    @question = @test.questions.new
  end

  def edit
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to test_path(@test)
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to test_path(@question.test)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to test_path(@question.test)
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_test_not_found
    render file: "public/404.html"
  end

  def rescue_with_constraint_error(e)
    @error = "#{e.message}"

    actions = {
      "create" => :new,
      "update" => :edit
    }

    if actions[action_name].nil?
      redirect_to test_path(@question.test)
    else
      render actions[action_name]
    end
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
