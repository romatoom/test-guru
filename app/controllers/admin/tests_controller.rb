class Admin::TestsController < Admin::BaseController
  before_action :set_test, only: %i(show edit update destroy start update_inline)
  before_action :set_tests, only: %i(index update_inline)

  def index
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
    set_time_to_pass

    if @test.save
      redirect_to admin_tests_path
    else
      render :new
    end
  end

  def update
    set_time_to_pass

    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
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

  def set_tests
    @tests = Test.all
  end

  def set_time_to_pass
    @test.time_to_pass = Converter::Time.hms_to_seconds(params[:test][:time_to_pass_str]);
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :published, :time_to_pass)
  end
end
