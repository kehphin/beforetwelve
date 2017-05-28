class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.string :status
      t.references :referrer
      t.references :referree
    end
  end
end
