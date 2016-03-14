class HomeController < ApplicationController
  def index
    @terms = Term.where(open: true)
  end
end
