class ApplicationsController < ApplicationController
  before_action :validate_logged_in, except: :new


  def index
    @applications = Application.all
  end

  def new
  end

  def edit
  end

  def update
  end

end
