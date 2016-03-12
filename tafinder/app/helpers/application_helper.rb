module ApplicationHelper

  def logged_in?
    session[:user_id].present?
  end

  def current_user
    User.find(session[:user_id])
  end

  def format_time(datetime)
    datetime.in_time_zone("Pacific Time (US & Canada)").strftime("%b %d, %Y %H:%M %Z")
  end

  def format_phone_number(phone_number)
    matches = phone_number.match(/(\d{3})[^\d]*(\d{3})[^\d]*(\d{4})/)
    "(#{matches[1]}) #{matches[2]}-#{matches[3]}" unless matches.nil?
  end

end
