class Admin::TestsController < Admin::BaseController
  before_action :set_test, only: %i(show edit update destroy start)

  rescue_from SQLite3::ConstraintException, with: :rescue_with_constraint_error

  def index
    @tests = Test.all
  end

  def show
  end

  def new
    @test = current_user.created_tests.new
  end

  def edit
  end

  def create
    @test = current_user.created_tests.new(test_params)

    if @test.save
      redirect_to admin_tests_path
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :edit
    end
  end

  def destroy
    @test.destroy

    redirect_to admin_tests_path
  end

  private
    def set_test
      @test = Test.find(params[:id])
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
