class AddPlusOneToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :plusone, :boolean, default: false
  end
end
