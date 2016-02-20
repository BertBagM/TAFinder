class ApplicationController < ActionController::Base
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def validate_logged_in
    unless logged_in?
      flash[:danger] = 'You do not have the correct permissions to view that page'
      redirect_to(root_path)
    end
  end
end
