class AddNameToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :name, :string
  end
end
