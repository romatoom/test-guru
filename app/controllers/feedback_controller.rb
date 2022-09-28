class FeedbackController < ApplicationController
  def index
    @feedback = Feedback.new
  end

  def send_feedback
    @feedback = Feedback.new(feedback_params)
    @user = current_user

    FeedbackMailer.send_feedback(@feedback, @user).deliver_now

    redirect_to root_path, notice: t("feedback.send_feedback.feedback_sent")
  end

  private

  def feedback_params
    params.require(:feedback).permit(:theme, :text)
  end
end
