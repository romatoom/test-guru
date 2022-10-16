module UsersTestsHelper
  def paragraph_for_test_result(user_test)
    if user_test.success?
      "<p class='fs-1 text-success'>#{user_test.result}% - #{t(".passed")}</p>".html_safe
    else
      "<p class='fs-1 text-danger'>#{user_test.result}% - #{t(".failed")}</p>".html_safe
    end
  end

  def time_left(user_test)
    time_has_passed = Time.now - user_test.created_at
    time_difference = user_test.test.time_to_pass_in_seconds - time_has_passed
    [0, time_difference].max
  end

  def progress_bar_classes(test_finished)
    test_finished ? "tg-progress-bar time-is-over mb-3" : "tg-progress-bar mb-3"
  end
end
