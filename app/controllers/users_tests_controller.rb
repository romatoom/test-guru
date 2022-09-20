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
    octokit_client = Octokit::Client.new(access_token: ENV['ACCESS_TOKEN_FOR_CREATE_GISTS'])

    gist_question_service = GistQuestionService.new(@user_test.current_question, client: octokit_client)
    gist_question_service.call

    gist_url = gist_question_service.gist_attr_value("html_url")

    if gist_url.present?

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

  def gist_params
    params.require(:gist).permit(:user, :question, :url)
  end
end
