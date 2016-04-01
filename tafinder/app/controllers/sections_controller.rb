class SectionsController < ApplicationController

  def new
    @course = Course.find(params[:course_id])
  end

  def create
    course = Course.find(section_params[:course_id])

    if (course.present?)
      section = course.sections.create(section_params)

      if (section.valid?)
        flash[:success] = "Your section has been created"
      else
        flash[:danger] = section.errors.full_messages.first
      end
    else
      flash[:danger] = "Could not find a course with the supplied ID"
    end

    redirect_to(url_for(controller: :courses, action: :index))
  end


  private

  def section_params
    params.require(:section).permit(
      :number,
      :instructor_name,
      :act_type,
      :start_time,
      :end_time,
      :lab_hours,
      :marking_hours,
      :coord_hours,
      :enrolled_est,
      :enrolled,
      :released,
      :capacity,
      :building,
      :room,
      :course_id
    )
  end
end
