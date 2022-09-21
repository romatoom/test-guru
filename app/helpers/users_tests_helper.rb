module UsersTestsHelper


  def paragraph_for_test_result(user_test)
    if user_test.success?
      "<p class='fs-1 text-success'>#{user_test.result_in_persent}% - #{t(".passed")}</p>".html_safe
    else
      "<p class='fs-1 text-danger'>#{user_test.result_in_persent}% - #{t(".failed")}</p>".html_safe
    end
  end
end
