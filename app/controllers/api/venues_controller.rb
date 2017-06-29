module Api
  class VenuesController < ApplicationController
    def index
      search_term = params['term']
      @venues = Venue.where('active = ?', true)

      json_response(@venues)
    end
  end
end
