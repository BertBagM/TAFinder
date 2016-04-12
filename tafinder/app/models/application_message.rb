class ApplicationMessage < ActiveRecord::Base

  def message_html(term, link)
    message.sub('$LINK', link_html(term, link)).html_safe
  end


  private

  def link_html(term, link)
    %{<a href="#{ link }">#{ term.year } #{ (term.semester == "fallWinter") ? "Fall/Winter" : "Spring/Summer" } TA Application - Term #{ term.semester_index }</a>}
  end

end
