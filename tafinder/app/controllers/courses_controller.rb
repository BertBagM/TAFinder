class CoursesController < ApplicationController
  before_action :validate_logged_in

  require 'spreadsheet'

  def index
    @courses = Course.all

    respond_to do |format|
      format.html
      format.csv { render text: @applications.to_csv }
      format.xls
    end

  end

  def import

    # params[:course_file]

    File.open("public/courses_data.xlsx", "r+") do |f|

      @workbook = Spreadsheet.open(f.first.attachment.to_file)

# Get the first worksheet in the Excel file
      @worksheet = @workbook.worksheet(0)

# It can be a little tricky looping through the rows since the variable
# @worksheet.rows often seem to be empty, but this will work:
      0.upto @worksheet.last_row_index do |index|
        # .row(index) will return the row which is a subclass of Array
        row = @worksheet.row(index)
        Courses.create[name: row[0], subject: row[1], number: row[2], section: row[4], term: row[5], act_type: row[6], days: row[7], start_time: row[8], end_time: row[9], lab: row[12], mark: row[13], coord: row[14], graduate: row[15], enrolled_est: row[17], enrolled: row[19], released: row[18], capacity: row[22], building: row[20], room: row[21]]


      end


      redirect_to(action: :index)
    end


  end

end