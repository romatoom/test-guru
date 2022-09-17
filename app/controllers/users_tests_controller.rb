class UsersTestsController < ApplicationController
  before_action :set_user_test, only: %i(show update result gist)

  def show
    redirect_to result_users_test_path(@user_test) if @user_test.finished?
  end

  def result
    redirect_to users_test_path(@user_test) unless @user_test.finished?
  end

  def update
    @user_test.accept!(params[:answer_ids])

    if @user_test.finished?
      TestsMailer.completed_test(@user_test).deliver_now
      redirect_to result_users_test_path(@user_test)
    else
      render :show
    end
  end

  def gist
    octokit_client = Octokit::Client.new(access_token: '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')
    result = GistQuestionService.new(@user_test.current_question, client: octokit_client).call

    flash_options = if result[:success]
      { notice: t(".success", link: result[:gist_url]) }
    else
      { notice: t(".failure") }
    end

    redirect_to @user_test, flash_options
  end

  private

  def set_user_test
    @user_test = UsersTest.find(params[:id])
  end
end
