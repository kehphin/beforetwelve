class AddToLoanTable < ActiveRecord::Migration[5.0]
  def change
    add_column(:loans, :why_loan, :text)
  end
end
