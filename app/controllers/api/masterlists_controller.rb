module Api
  class MasterlistsController < ApplicationController
    def create
      byebug

      render json: { data: 'wee' }, status: :created
    end
  end
end
