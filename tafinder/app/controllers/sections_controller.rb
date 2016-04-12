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
      flash[:danger] = "Could not find a section with the supplied ID"
    end

    redirect_to(url_for(controller: :courses, action: :index))
  end


  def edit
    @section = Section.find(params[:id])

    if @section.nil?
      flash[:warning] = "No section was found with ID #{params[:id]}."
      redirect_to(action: :index)
    end
  end


  def update
    @section = Section.find(params[:id])

    if @section.update_attributes(section_params)
      redirect_to(url_for(controller: :courses, action: :index))
    else
      flash[:danger] = "Unable to modify section."
      render(action: :edit)
    end
  end


  def destroy
    @section = Section.find(params[:id])

    if @section.destroy()
      flash[:success] = "The section has been removed."
    else
      flash[:danger] = "Unable to remove the section."
    end

    redirect_to(url_for(controller: :course, action: :index))
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
      :ta_name,
      :capacity,
      :building,
      :room,
      :course_id
    )
  end
end
