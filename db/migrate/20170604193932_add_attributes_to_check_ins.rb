class AddAttributesToCheckIns < ActiveRecord::Migration[5.1]
  def change
    add_column :check_ins, :master_checkin, :boolean, default: false
    add_column :check_ins, :plusone_checkin, :boolean, default: false
  end
end
