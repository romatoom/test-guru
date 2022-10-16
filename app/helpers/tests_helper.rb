module TestsHelper
  def test_header(test)
    if test.new_record?
      t(".create_new_test")
    else
      t(".edit_test")
    end
  end

  def time_to_pass_readable(test)
    test.time_test? ? test.time_to_pass : t("common.not_set")
  end
end
