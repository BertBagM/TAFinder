class UserMailer < ApplicationMailer

  def revoke_application_request_email(application)
    @application = application
    @admins = User.all

    @admins.each do |admin|
      mail(to: admin.email, from: @application.email, subject: "Application Removal Request from #{@application.full_name}")
    end
  end

end
