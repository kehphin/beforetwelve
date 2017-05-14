class AddPointsUsedToLoan < ActiveRecord::Migration[5.0]
  def change
    add_column(:loans, :points_used, :integer, default: 0)
  end
end
