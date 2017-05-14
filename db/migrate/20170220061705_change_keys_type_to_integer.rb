class ChangeKeysTypeToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :loans, :keys, :integer
  end
end
