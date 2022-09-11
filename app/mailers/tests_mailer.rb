class TestsMailer < ApplicationMailer
  def completed_test(user_test)
    @user = user_test.user
    @test = user_test.test

    mail to: @user.email, subject: t("mail.test_complete")
  end
end
