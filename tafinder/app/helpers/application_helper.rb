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

end
