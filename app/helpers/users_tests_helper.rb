module UsersTestsHelper
  def paragraph_for_test_result(user_test)
    if user_test.success?
      "<p class='test-result passed'>#{user_test.result_in_persent}% - вы прошли тест</p>".html_safe
    else
      "<p class='test-result failed'>#{user_test.result_in_persent}% - вы не прошли тест</p>".html_safe
    end
  end
end
