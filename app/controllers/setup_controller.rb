class SetupController < ApplicationController
  before_action :authenticate_user!

  def index
    params.require(:uid)

    @user = User.find_by(uid: params['uid'])

    render :setup
  end
end
