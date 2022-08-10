module UsersTestsHelper
  def test_result_in_persent(user_test)
    result = (user_test.correct_answers.to_f / user_test.questions_count * 100).round

    if test_passed?(result)
      "<p class='test-result passed'>#{result}% - вы прошли тест</p>".html_safe
    else
      "<p class='test-result failed'>#{result}% - вы не прошли тест</p>".html_safe
    end
  end

  def test_passed?(result_in_percent)
    result_in_percent >= 85
  end
end
