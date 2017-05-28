class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :referral_code
  end
end
