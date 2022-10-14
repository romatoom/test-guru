module TestsHelper
  TIME_RANGES_FOR_SELECT = {
    hours: 0..23,
    minutes: 0..59,
    seconds: 0..59
  }

  SECONDS_IN_HOUR = 3600
  SECONDS_IN_MINUTE = 60

  def test_header(test)
    if test.new_record?
      t(".create_new_test")
    else
      t(".edit_test")
    end
  end

  def time_to_pass_readable(test)
    time_in_seconds = test.time_to_pass

    if test.time_test?
      h = formatter(hours(time_in_seconds))
      m = formatter(minutes(time_in_seconds))
      s = formatter(seconds(time_in_seconds))
      "#{h}:#{m}:#{s}"
    else
      t("common.not_set")
    end
  end

  def formatter(val)
    val < 10 ? "0#{val}" : val.to_s
  end

  def hours(time_in_seconds)
    time_in_seconds / SECONDS_IN_HOUR
  end

  def minutes(time_in_seconds)
    time_in_seconds % SECONDS_IN_HOUR / SECONDS_IN_MINUTE
  end

  def seconds(time_in_seconds)
    time_in_seconds % SECONDS_IN_HOUR % SECONDS_IN_MINUTE
  end

  def range_for(part_time)
    (TIME_RANGES_FOR_SELECT[part_time]).map { |h| formatter(h) }
  end
end
