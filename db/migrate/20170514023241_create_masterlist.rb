class CreateMasterlist < ActiveRecord::Migration[5.1]
  def change
    create_table :masterlists do |t|
      t.string :name
    end
  end
end
