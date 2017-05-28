class AddDefaultFalseToGuestCheckedIn < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:guests, :checked_in, false)
  end
end
