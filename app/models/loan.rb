class Loan < ApplicationRecord
  validates_acceptance_of :terms
  # validates :keys, numericality: { only_integer: true }
  validates_with PointsValidator

  attr_accessor :terms

  belongs_to :user
end

class PointsValidator < ActiveModel::Validator
  def validate(loan)
    if (loan.user.total_points / 100) < loan.points_used
      loan.errors[:base] << "Too many keys redeemed"
    end
  end
end

