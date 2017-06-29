module Api
  class CheckInsController < ApplicationController
    def create
      user_id = params['data']['user_id']
      guest_id = params['data']['guest_id']
      venue_id = params['data']['venue_id']
      master_checkin = ActiveModel::Type::Boolean.new.cast(params['data']['master_checkin'])
      plusone_checkin = ActiveModel::Type::Boolean.new.cast(params['data']['plusone_checkin'])

      # User Checkin
      if user_id.present?
        check_in = CheckIn.create(user_id: user_id, venue_id: venue_id, master_checkin: master_checkin, plusone_checkin: plusone_checkin)
        json_response({ user_name: User.find(user_id).name, venue_name: Venue.find(venue_id).name, master_checkin: master_checkin, plusone_checkin: plusone_checkin })
      # Guest Checkin
      elsif guest_id.present?
        check_in = CheckIn.create(guest_id: guest_id, venue_id: venue_id, master_checkin: master_checkin, plusone_checkin: plusone_checkin)
        json_response({ guest_name: Guest.find(guest_id).name, venue_name: Venue.find(venue_id).name, master_checkin: master_checkin, plusone_checkin: plusone_checkin })
      # Masterlist Checkin
      else
        check_in = CheckIn.create(venue_id: venue_id, master_checkin: master_checkin, plusone_checkin: plusone_checkin)
        json_response({ venue_name: Venue.find(venue_id).name, master_checkin: master_checkin, plusone_checkin: plusone_checkin })
      end
    end
  end
end
