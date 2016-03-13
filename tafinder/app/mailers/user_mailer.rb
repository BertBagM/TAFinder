class UserMailer < ApplicationMailer

  def change_application_request_email(application, message)
    @message = message
    @application = application
    @admins = User.all

    @admins.each do |admin|
      mail(to: admin.email, from: @application.email, subject: "Application Modification Request from #{@application.full_name}")
    end
  end

end
