class RemoveReferencesFromGuests < ActiveRecord::Migration[5.1]
  def change
    remove_reference :guests, :masterlist
    remove_reference :guests, :guestlist
  end
end
