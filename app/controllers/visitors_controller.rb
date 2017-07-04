class VisitorsController < ApplicationController
  def index
    @guest = Guest.new

    render :index
  end

end
