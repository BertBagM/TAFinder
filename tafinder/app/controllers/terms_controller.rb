class TermsController < ApplicationController

  def index
    @terms = Term.all
    @semester_options = Term.semesters
  end

  def create
    term = Term.create(term_params)

    if (!term.valid?)
      flash[:danger] = term.errors.full_messages.first
    end

    redirect_to(action: :index)
  end

  def update
    term = Term.find(params[:id])

    if (term.present? && term_params[:open].present?)
      term.open = term_params[:open]

      if (term.open)
        Term.where(open: true).update_all(open: false)
      end

      if (term.save())
        flash[:success] = "Term #{term.to_s} has been #{term_params[:open] ? "opened" : "closed"}."
      else
        flash[:danger] = "Failed to #{term_params[:open] ? "open" : "close"} term #{term.to_s}."
      end
    end

    redirect_to(action: :index)
  end


  private

  def term_params
    params.require(:term).permit(
      :year,
      :semester,
      :open
    )
  end
end
