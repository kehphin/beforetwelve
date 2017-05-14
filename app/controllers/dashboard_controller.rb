class DashboardController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user?, :except => [:index]

  def index
    @loans = Loan.all

    render :index
  end

  # def show
  #   @user = User.find(params[:id])
  # end

end
