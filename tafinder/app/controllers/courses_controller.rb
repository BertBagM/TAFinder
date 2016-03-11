class CoursesController < ApplicationController
  before_action :validate_logged_in


  def index
    @courses = Course.all
  end

  def import
    
  end
end
