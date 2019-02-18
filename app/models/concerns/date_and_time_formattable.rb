module DateAndTimeFormattable
  # en dash
  DASH = "–"
  
  # e.g. Jan 1, 2018
  DATE_FORMAT = "%b %-d, %Y"

  # e.g. 6
  HOUR_FORMAT = "%-l"

  # e.g. PM
  MERIDIAN_FORMAT = "%p"

  # e.g. 6:00
  TIME_FORMAT = "#{HOUR_FORMAT}:%M"

  def date_and_time_format(datetime)
    datetime.strftime("#{DATE_FORMAT} #{hour_or_time_format(datetime)} #{MERIDIAN_FORMAT}")
  end

  def date_and_time_range_format(start_time, end_time)
    output = start_time.strftime("#{DATE_FORMAT} #{hour_or_time_format(start_time)}")

    if start_time.beginning_of_day == end_time.beginning_of_day
      output += DASH
    else
      output += start_time.strftime(" #{MERIDIAN_FORMAT}")
      output += end_time.strftime(" #{DASH} #{DATE_FORMAT} ")
    end

    output + end_time.strftime("#{hour_or_time_format(end_time)} #{MERIDIAN_FORMAT}")
  end

  def date_format(datetime)
    datetime.strftime(DATE_FORMAT)
  end

  def time_format(datetime)
    datetime.strftime(hour_or_time_format(datetime))
  end

  private

  def hour_or_time_format(datetime)
    if datetime == datetime.beginning_of_hour
      HOUR_FORMAT
    else
      TIME_FORMAT
    end
  end
end
