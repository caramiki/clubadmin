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

  private

  def date_and_time_format(datetime)
    local_time(datetime).strftime("#{DATE_FORMAT} #{hour_or_time_format(datetime)} #{MERIDIAN_FORMAT}")
  end

  def date_and_time_range_format(start_time, end_time)
    start_time_local = local_time(start_time)
    end_time_local = local_time(end_time)

    output = start_time_local.strftime("#{DATE_FORMAT} #{hour_or_time_format(start_time)}")

    if start_time_local.beginning_of_day == end_time_local.beginning_of_day
      output += DASH
    else
      output += start_time_local.strftime(" #{MERIDIAN_FORMAT}")
      output += end_time_local.strftime(" #{DASH} #{DATE_FORMAT} ")
    end

    output + end_time_local.strftime("#{hour_or_time_format(end_time)} #{MERIDIAN_FORMAT}")
  end

  def date_format(datetime)
    local_time(datetime).strftime(DATE_FORMAT)
  end

  def hour_or_time_format(datetime)
    if local_time(datetime) == local_time(datetime).beginning_of_hour
      HOUR_FORMAT
    else
      TIME_FORMAT
    end
  end

  def local_time(datetime)
    datetime.in_time_zone(club.timezone)
  end

  def time_format(datetime)
    local_time(datetime).strftime(hour_or_time_format(datetime))
  end
end
