class CheckIn < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :guest, optional: true
  belongs_to :venue
end
