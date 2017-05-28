class Guestlist < ApplicationRecord
  belongs_to :user
  has_many :guest, dependent: :destroy
end
