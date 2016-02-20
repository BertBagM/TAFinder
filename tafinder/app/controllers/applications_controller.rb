class ApplicationsController < ApplicationController
  before_action :validate_logged_in, except: [:create, :new]


  def index
    @applications = Application.all
  end

  def create
    @applications = Application.create(application_params())
  end

  def new
  end

  def edit
  end

  def update
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
