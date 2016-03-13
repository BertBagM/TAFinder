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
      begin
        # First try an extended login. If it fails because the
        # server doesn't support it, fall back to a normal login
        row = @worksheet.row(index)
        Course.create(name: row[0], subject: row[1], number: row[2], section: row[4], term: row[5], act_type: row[6],  days: row[7], start_time: row[8], end_time: row[9], lab: row[12], mark: row[13], coord: row[14], graduate: row[15], enrolled_est: row[17], enrolled: row[19], released: row[18], capacity: row[22], building: row[20], room: row[21])

      rescue


      end




    end


    redirect_to(action: :index)
  end


end