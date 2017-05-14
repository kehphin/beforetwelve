class AddCompletedToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :setup_completed, :boolean, default: false
  end
end
