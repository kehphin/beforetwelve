class Guest < ApplicationRecord
  belongs_to :guestlist, optional: true
  belongs_to :masterlist
end
