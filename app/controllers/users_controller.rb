class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, :except => [:index]

  def index
    @users = User.order('created_at DESC')
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    hash_params = user_params.to_h

    @user.update(hash_params.merge({ setup_completed: true }))

    redirect_to dashboard_path
  end

  def user_params
    params.required(:user).permit(:first_name, :last_name, :email, :phone_number)
  end
end
