class TestsController < ApplicationController
  before_action :set_test, only: %i(show edit update destroy start)
  before_action :set_user, only: %i(new create start)

  rescue_from SQLite3::ConstraintException, with: :rescue_with_constraint_error

  def index
    @tests = Test.all
  end

  def show
  end

  def new
    @test = @user.created_tests.new
  end

  def edit
  end

  def create
    @test = @user.created_tests.new(test_params)

    if @test.save
      redirect_to tests_path
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to tests_path
    else
      render :edit
    end
  end

  def destroy
    @test.destroy

    redirect_to tests_path
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.user_test(@test)
  end

  private
    def set_test
      @test = Test.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def rescue_with_constraint_error(e)
      flash.now[:danger] = "Произошла ошибка: #{e.message}"

      actions = {
        "create" => :new,
        "update" => :edit
      }

      if actions[action_name].nil?
        render :index
      else
        render actions[action_name]
      end
    end

    def test_params
      params.require(:test).permit(:title, :level, :category_id)
    end
end
