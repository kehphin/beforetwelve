class AddAttributesToVenue < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :active, :boolean, default: true
  end
end
