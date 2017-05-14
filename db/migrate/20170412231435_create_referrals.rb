class CreateReferrals < ActiveRecord::Migration[5.0]
  def change
    create_table :referrals do |t|
      t.string :status
      t.references :referrer
      t.references :referree

      t.timestamps
    end
  end
end
