class Admin::TestsController < Admin::BaseController
  before_action :set_test, only: %i(show edit update destroy start update_inline publish unpublish)
  before_action :set_tests, only: %i(index update_inline publish unpublish)

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

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def publish
    @test.published_at = Time.now
    @test.save
    redirect_to admin_tests_path
  end

  def unpublish
    @test.published_at = nil
    @test.save
    redirect_to admin_tests_path
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

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end
end
