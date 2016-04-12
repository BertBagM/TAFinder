class CoursesController < ApplicationController
  before_action :validate_logged_in


  def index
    @courses = Course.all.order(subject: :asc, number: :asc)

    respond_to do |format|
      format.html
      format.csv { render text: @courses.to_csv }
      format.xls
    end
  end


  def new
    @terms = Term.all.order(year: :desc, semester: :desc)
  end


  def create
    term = Term.find(course_params[:term_id])

    if (term.present?)
      course = term.courses.create(course_params)

      if (course.valid?)
        flash[:success] = "Your course has been created"
      else
        flash[:danger] = course.errors.full_messages.first
      end
    else
      flash[:danger] = "Could not find a term with the supplied ID"
    end

    redirect_to(action: :index)
  end


  def import
    require 'spreadsheet'
    # params[:course_file]
    Spreadsheet.client_encoding = 'UTF-8'

    workbook = Spreadsheet.open(Rails.root.to_s + '/public/courses_data.xls')

    # Get the first worksheet in the Excel file
    @worksheet = workbook.worksheet(0)

    # It can be a little tricky looping through the rows since the variable
    # @worksheet.rows often seem to be empty, but this will work:
    0.upto @worksheet.last_row_index do |index|
      # .row(index) will return the row which is a subclass of Array
      # First try an extended login. If it fails because the
      # server doesn't support it, fall back to a normal login
      row = @worksheet.row(index)



      term_id = Term.where(open: true).first.id


      return if term_id.nil?



      ## gets course_id query

      course = Course.where(subject: row[1], number: row[2], term_id: term_id).first
      if (course.nil?)
          course =   Course.create(
            subject: row[1],
            number: row[2],
            term_id: term_id,
            graduate: row[15]
        )



      end

      course_id = course.id

      #create each section
      Section.create(
          course_id: course_id,
          number: row[4],
          instructor_name: row[0],
          act_type: row[6],
          days: row[7],
          start_time: row[8],
          end_time: row[9],
          lab_hours: row[11].to_i,
          marking_hours: row[12].to_i,
          coord_hours: row[13].to_i,
          ta_name: row[10],
          hours: row[17].to_i,
          enrolled_est: row[18].to_i,
          enrolled: row[19].to_i,
          released: row[18].to_i,
          capacity: row[22].to_i,
          building: row[20],
          room: row[21]
      )
    end




    redirect_to(action: :index)
  end


  def edit
    @course = Course.find(params[:id])
    @terms = Term.all.order(year: :desc, semester: :desc)

    if @course.nil?
      flash[:warning] = "No course was found with ID #{params[:id]}."
      redirect_to(action: :index)
    end
  end


  def update
    @course = Course.find(params[:id])

    if @course.update_attributes(course_params)
      redirect_to(action: :index)
    else
      flash[:danger] = "Unable to modify Course."
      render(action: :edit)
    end
  end


  def destroy
    @course = Course.find(params[:id])

    if @course.destroy()
      flash[:success] = "The course has been removed."
    else
      flash[:danger] = "Unable to remove the course."
    end

    redirect_to(action: :index)
  end


  private

  def course_params
    params.require(:course).permit(
      :subject,
      :number,
      :graduate,
      :term_id
    )
  end

end
