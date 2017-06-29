module Api
  class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      render json: { data: 'wee' }, status: :created
    end

    def index
      search_term = params['term']
      @users = User.where("name ILIKE ?", "%#{search_term}%")

      json_response(@users)
    end
  end
end
