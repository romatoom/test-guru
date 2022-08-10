class UsersTestsController < ApplicationController
  before_action :set_user_test, only: %i(show update result)

  def show
    redirect_to result_users_test_path(@user_test) if @user_test.finished?
  end

  def result
    redirect_to users_test_path(@user_test) unless @user_test.finished?
  end

  def update
    @user_test.accept!(params[:answer_ids])

    if @user_test.finished?
      redirect_to result_users_test_path(@user_test)
    else
      render :show
    end
  end

  private

  def set_user_test
    @user_test = UsersTest.find(params[:id])
  end
end
