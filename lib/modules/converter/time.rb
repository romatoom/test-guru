module Converter
  class Time
    def self.hms_to_seconds(time_in_hms)
      DateTime.parse(time_in_hms).seconds_since_midnight.to_i
    end

    def self.seconds_to_hms(time_in_seconds)
      DateTime.strptime(time_in_seconds.to_s, '%s').strftime("%H:%M:%S")
    end
  end
end
