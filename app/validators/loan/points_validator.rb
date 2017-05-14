class Loan::PointsValidator < ActiveModel::Validator
  def validate(loan)
    if (loan.user.total_points / 100) < loan.points_used
      loan.errors[:base] << "Too many keys redeemed"
    end
  end
end
