class ApplicationMessageController < ApplicationController
  before_action :validate_logged_in


  def edit
    @message = ApplicationMessage.first
  end

  def update
    @message = ApplicationMessage.first

    if @message.update_attributes(application_message_params)
      redirect_to(url_for(controller: :applications, action: :index))
    else
      flash[:danger] = "Unable to modify application message."
      render(action: :edit)
    end
  end


  private

  def application_message_params
    params.require(:application_message).permit(
      :message
    )
  end

end
