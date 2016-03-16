class ApplicationsController < ApplicationController
  before_action :validate_logged_in, except: [:create, :new, :change, :request_change]
  before_action :sanatize_params, only: [:create, :update]


  def index
    @applications = Application.all.joins(:term)
    @applications = @applications.all.joins(:ranking)
    @order_options = order_params()
    @order_dir_options = order_dir_params()

    if (params[:q].present?)
      query = "%#{params["q"]}%"
      @applications = @applications.where(
        "student_id LIKE ? OR "\
        "first_name LIKE ? OR "\
        "last_name LIKE ? OR "\
        "email LIKE ?",
      query, query, query, query)
    end

    if (params[:filter_term] == "on")
      @applications = @applications.where(term: { open: true })
    end

    if (params[:filter_grad] == "on")
      @applications = @applications.where(graduate: true)
    end

    if (validate_param(params[:order], order_params))
      order_dir = validate_param(params[:order_dir], order_dir_params) ? params[:order_dir] : :asc
      @applications = @applications.order(params[:order] => order_dir)
    end

    respond_to do |format|
      format.html
      format.csv { render text: @applications.to_csv }
      format.xls
    end
  end

  def create
    term = Term.where(id: application_params[:term_id])

    if (term.present?)
      application = Application.new(application_params)

      if (params[:course].present? && params[:course][:ids].present?)
        params[:course][:ids].each do |course_id|
          application.preferred_courses.new(course_id: course_id)
        end
      end

      application.save()

      if (application.valid?)
        flash[:success] = "Your application has been submitted"
      else
        flash[:danger] = application.errors.full_messages.first
      end
    else
      flash[:danger] = "Could not find terms with the supplied IDs"
    end

    redirect_to(action: :new)
  end

  def new
    @courses = Course.all
    @term_options = Term.where(open: true)
  end

  def edit
    @application = Application.find_by_id(params[:id])
    @courses = Course.all
    @term_options = Term.all

    if @application.nil?
      flash[:warning] = "No applications were found with ID #{params[:id]}."
      redirect_to(action: :index)
    end
  end

  def update
    @application = Application.find(params[:id])

    if @application.update_attributes(application_params)
      redirect_to(action: :index)
    else
      flash[:danger] = "Unable to modify application."
      render(action: :edit)
    end
  end

  def change
    @term_options = Term.all
  end

  def request_change
    # TODO(scott): we also need to find_by year and semester
    @application = Application.joins(:term).find_by(student_id: application_params[:student_id], term: {id: application_params[:term_id]})

    if @application.present?
      flash[:success] = "An email has been sent requesting for your application to be changed."

      UserMailer.change_application_request_email(@application, params[:message]).deliver
    else
      flash[:danger] = "Could not find an application associated with that email."
    end

    redirect_to(action: :change)
  end

  def destroy
    @application = Application.find(params[:id])

    if @application.destroy()
      flash[:success] = "The application has been removed."
    else
      flash[:danger] = "Unable to remove the application."
    end

    redirect_to(action: :index)
  end

  private

  def application_params
    params.require(:application).permit(
      :student_id,
      :first_name,
      :last_name,
      :email,
      :gpa,
      :faculty,
      :study_year,
      :graduate,
      :graduate_full_time,
      :ubc_employee_id,
      :program,
      :gender,
      :street,
      :city,
      :postal_code,
      :home_phone,
      :cell_phone,
      :previous_ta,
      :preferred_hours,
      :maximum_hours,
      :term_id
    )
  end

  def sanatize_params
    params[:application][:cell_phone] = format_phone_number(application_params[:cell_phone])
    params[:application][:home_phone] = format_phone_number(application_params[:home_phone])
  end

  def order_params
    {
      position: "Ranked Position",
      created_at: "Date Created",
      student_id: "Student Number",
      first_name: "First Name",
      last_name: "Last Name",
      email: "Email",
      gpa: "GPA",
      faculty: "Faculty",
      study_year: "Year of Study"
    }
  end

  def order_dir_params
    {
      asc: "Ascending",
      desc: "Descending"
    }
  end

  def validate_param(param, valid_params)
    valid_params.keys().map{ |k| k.to_s }.include?(param)
  end

end
