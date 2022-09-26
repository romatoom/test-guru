class FeedbackMailer < ApplicationMailer
  include ApplicationHelper
  helper :application

  def send_feedback(feedback, user)
    @feedback = feedback
    @user = user
    mail to: admin_email, subject: t(".subject")
  end
end
