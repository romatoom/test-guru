class TestsController < ApplicationController
  before_action :set_test, only: %i(start)

  rescue_from SQLite3::ConstraintException, with: :rescue_with_constraint_error

  def index
    @tests = Test.all
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.user_test(@test)
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
end
