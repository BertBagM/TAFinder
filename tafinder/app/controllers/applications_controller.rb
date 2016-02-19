class ApplicationsController < ApplicationController
  before_action :validate_logged_in, except: :new


  def index
    @applications = Application.all
  end

  def new
  end

  def edit
    @application = Application.find_by_id(params[:id])

    flash[:warning] = "No applications were found with ID #{params[:id]}."
    redirect_to(action: :index) unless @application.present?
  end

  def update
  end

end
