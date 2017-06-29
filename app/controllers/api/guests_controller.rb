module Api
  class GuestsController < ApplicationController
    def show
      @user = Guest.find(params[:id])
      render json: { data: 'wee' }, status: :created
    end

    def index
      search_term = params['term']
      @guests = Guest.where("name ILIKE ?", "%#{search_term}%")

      json_response(@guests)
    end
  end
end
