module Converter
  module Time
    def hms_to_seconds(hms_string)
      time_arr = hms_string.split(':')
      raise "Unsupported time format" unless time_arr.length == 3

      h, m, s = time_arr.map { |el| el.to_i }
      h.hours.to_i + m.minutes.to_i + s.to_i
    end
  end
end
