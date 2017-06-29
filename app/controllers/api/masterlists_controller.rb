module Api
  class MasterlistsController < ApplicationController
    def create
      render json: { data: 'wee' }, status: :created
    end
  end
end
