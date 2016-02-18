class AdminController < ApplicationController
  before_action :validate_logged_in


  def validate_logged_in
    redirect_to('/') unless logged_in?
  end
end