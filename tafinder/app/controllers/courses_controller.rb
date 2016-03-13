class CoursesController < ApplicationController
  before_action :validate_logged_in


  def index
    @courses = Course.all

    respond_to do |format|
      format.html
      format.csv { render text: @applications.to_csv }
      format.xls
    end

  end

  def import

    require 'spreadsheet'
    # params[:course_file]
    Spreadsheet.client_encoding = 'UTF-8'

    workbook = Spreadsheet.open 'public/courses_data.xls'

    # Get the first worksheet in the Excel file
    @worksheet = workbook.worksheet(0)

    # It can be a little tricky looping through the rows since the variable
    # @worksheet.rows often seem to be empty, but this will work:
    0.upto @worksheet.last_row_index do |index|
      # .row(index) will return the row which is a subclass of Array
      # First try an extended login. If it fails because the
      # server doesn't support it, fall back to a normal login
      row = @worksheet.row(index)

      next if (row[6] == "LEC" || row[0] == "Instructor Name")

      Course.create(
        subject: row[1],
        number: row[2],
        section: row[4],
        term: row[5],
        act_type: row[6],
        days: row[7],
        start_time: row[8],
        end_time: row[9],
        lab_time: row[11].to_i,
        mark_time: row[12].to_i,
        coord_time: row[13].to_i,
        enrolled_est: row[16].to_i,
        enrolled: row[19].to_i,
        released: row[18].to_i,
        capacity: row[22].to_i,
        building: row[20],
        room: row[21]
      )
    end

    redirect_to(action: :index)
  end


end