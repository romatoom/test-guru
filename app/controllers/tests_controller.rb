class TestsController < ApplicationController
  before_action :set_test, only: %i(show edit update destroy)

  rescue_from SQLite3::ConstraintException, with: :rescue_with_constraint_error

  def index
    @tests = Test.all
  end

  def show
    redirect_to test_questions_url(@test)
  end

  def new
    @test = Test.new
  end

  def edit
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to tests_url
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to tests_url
    else
      render :edit
    end
  end

  def destroy
    @test.destroy

    redirect_to tests_url
  end

  private
    def set_test
      @test = Test.find(params[:id])
    end

    def rescue_with_constraint_error(e)
      @error = "#{e.message}"

      actions = {
        "create" => :new,
        "update" => :edit
      }

      if !actions[action_name].nil?
        render actions[action_name]
      else
        redirect_to tests_url
      end
    end

    # Получение пользователя, который создаёт тест. Пока не сделали авторизацию, будем возвращать первого пользователя
    def author
      User.first
    end

    def test_params
      t_params = params.require(:test).permit(:title, :level, :category_id)
      t_params[:author_id] = @test.nil? ? author.id : @test.author.id
      t_params
    end
end
