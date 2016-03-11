class TermsController < ApplicationController
  def index
    @terms = Term.all
  end

  def create
    Term.create(term_params)

    redirect_to(action: :index)
  end

  def open
    term = Term.find(params[:id])
    term.open = true

    if (term.save())
      flash[:success] = "Term #{term.to_s} has been opened."
    else
      flash[:error] = "Failed to open term #{term.to_s}."
    end

    redirect_to(action: :index)
  end

  def close
    term = Term.find(params[:id])
    term.open = false

    if (term.save())
      flash[:success] = "Term #{term.to_s} has been closed."
    else
      flash[:error] = "Failed to close term #{term.to_s}."
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
