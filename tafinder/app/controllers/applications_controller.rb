class ApplicationsController < ApplicationController
  before_action :validate_logged_in, except: [:create, :new]


  def index
    @applications = Application.all
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

end
