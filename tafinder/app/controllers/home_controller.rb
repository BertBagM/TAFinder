class HomeController < ApplicationController
  def index
    term = Term.where(open: true).first
    link = url_for(controller: :applications, action: :new)
    @message = ApplicationMessage.first.message_html(term, link) if (term.present?)
  end
end
