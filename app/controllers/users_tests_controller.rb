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
      @user_test.successfully = @user_test.result_in_persent >= UsersTest::MIN_PERCENT_SUCCESS_PASSED_TEST
      @user_test.save!

      # @all_successful_user_tests = UsersTest.successfully_by_user(@user_test.user)

      TestsMailer.completed_test(@user_test).deliver_now
      redirect_to result_users_test_path(@user_test)
    else
      render :show
    end
  end

  def gist
    octokit_client = Octokit::Client.new(access_token: ENV['ACCESS_TOKEN_FOR_CREATE_GISTS'])
    octokit_client_adapter = OctokitClientAdapter.new(octokit_client)

    gist_question_service = GistQuestionService.new(@user_test.current_question, client: octokit_client_adapter)
    gist_question_service.call

    if gist_question_service.success?
      gist_url = gist_question_service.gist["html_url"]

      gist = Gist.new(
        user: @user_test.user,
        question: @user_test.current_question,
        link_url: gist_url
      )

      gist.save

      flash_options = { notice: t(".success", link: helpers.link_to("Gist", gist_url, target: "_blank")) }
    else
      flash_options = { notice: t(".failure") }
    end

    redirect_to @user_test, flash_options
  end

  private

  def set_user_test
    @user_test = UsersTest.find(params[:id])
  end
end
