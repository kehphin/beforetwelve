class AddSetupCompletedToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :setup_completed, :boolean
  end
end
