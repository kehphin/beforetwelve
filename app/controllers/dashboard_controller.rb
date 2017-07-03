class DashboardController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user?, :except => [:index]

  def index
    if current_user.superuser?
      @users = User.order('created_at DESC').limit(5)
      @guests = Guest.order('created_at DESC').limit(5)
      @check_ins = CheckIn.order('created_at DESC').limit(5)
    else
      @check_ins = CheckIn.where(user_id: current_user.id)
    end

    # [[7, 13], [8, 1]]    [id, check_ins]
    @leaderboard_hosts = CheckIn.group(:user_id).count().except(nil).sort_by { |id, check_ins| -check_ins }[0..5]

    render :index
  end
end
