class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
      t.string :status
      t.decimal :keys
      t.datetime :due_at
      t.string :collateral
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
