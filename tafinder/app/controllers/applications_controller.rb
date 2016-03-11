class ApplicationsController < ApplicationController
  before_action :validate_logged_in, except: [:create, :new, :delete, :request_revoke]


  def index
    @order_options = order_params()
    @order_dir_options = order_dir_params()

    if (params[:q].present?)
      query = "%#{params["q"]}%"
      @applications = Application.where(
        "studentNum LIKE ? OR "\
        "firstName LIKE ? OR "\
        "lastName LIKE ? OR "\
        "email LIKE ?",
      query, query, query, query)
    else
      @applications = Application.all
    end

    if (params[:filter_term] == "on")
      #TODO: filter current term here
    end

    if (params[:filter_grad] == "on")
      @applications = @applications.where(graduateStudent: true)
    end

    if (validate_param(params[:order], order_params))
      order_dir = validate_param(params[:order_dir], order_dir_params) ? params[:order_dir] : :asc
      @applications = @applications.order(params[:order], order_dir)
    end

    respond_to do |format|
      format.html
      format.csv { render text: @applications.to_csv }
      format.xls
    end
  end

  def create
    if @applications = Application.create(application_params())
      flash[:success] = "Your application has been submitted."
    else
      flash[:danger] = "Unable to create application."
    end

    render(action: :new)
  end

  def new
  end

  def edit
    @application = Application.find_by_id(params[:id])

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

  def delete
  end

  def request_revoke
    # TODO(scott): we also need to find_by year and semester
    @application = Application.find_by(email: application_params[:email])

    if @application.present?
      flash[:success] = "An email has been sent requesting for your application to be revoked."

      UserMailer.revoke_application_request_email(@application).deliver
    else
      flash[:danger] = "Could not find an application associated with that email."
    end

    redirect_to(action: :delete)
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
      :studentNum,
      :firstName,
      :lastName,
      :email,
      :GPA,
      :faculty,
      :yearOfStudy,
      :graduateStudent,
      :ubcEmployeeId,
      :program,
      :gender,
      :streetAddress,
      :city,
      :postalCode,
      :homePhone,
      :cellPhone,
      :graduateFTStatus,
      :previousUTAPosition,
      :preferredHours,
      :maximumHours
    )
  end

  private

  def application_params
    params.require(:application).permit(
      :studentNum,
      :firstName,
      :lastName,
      :email,
      :GPA,
      :faculty,
      :yearOfStudy,
      :graduateStudent,
      :ubcEmployeeId,
      :program,
      :gender,
      :streetAddress,
      :city,
      :postalCode,
      :homePhone,
      :cellPhone,
      :graduateFTStatus,
      :previousUTAPosition,
      :preferredHours,
      :maximumHours
    )
  end

  def order_params
    {
      created_at: "Date Created",
      studentNum: "Student Number",
      firstName: "First Name",
      lastName: "Last Name",
      email: "Email",
      GPA: "GPA",
      faculty: "Faculty",
      yearOfStudy: "Year of Study"
    }
  end

  def order_dir_params
    {
      asc: "Ascending",
      desc: "Descending"
    }
  end

  def validate_param(param, valid_params)
    valid_params.keys().include?(param)
  end

end
