module ApplicationHelper

  def time_ago(time)
    return "0 minutes ago" if time.nil?
    #Added this to resolve the error: can't convert NilClass
    #into an exact number when trying to pass an empty comment


    seconds_ago = Time.now - time

    case seconds_ago
    when 0..59
      "#{seconds_ago.to_i}s"
    when 60..3599
      "#{(seconds_ago / 60).to_i}m"
    when 3600..86399
      "#{(seconds_ago / 3600).to_i}h"
    when 86400..604799
      "#{(seconds_ago / 86400).to_i}d"
    when 604800..2591999
      "#{(seconds_ago / 604800).to_i}w"
    when 2592000..31535999
      "#{(seconds_ago / 2592000).to_i}m"
    else
      "#{(seconds_ago / 31536000).to_i}y"
    end
  end

  def format_date(date)
    date.strftime("%b %d, %Y")
  end

end
