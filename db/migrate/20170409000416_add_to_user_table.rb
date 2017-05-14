class AddToUserTable < ActiveRecord::Migration[5.0]
  def change
    add_column(:users, :trade_url, :string)
    add_column(:users, :cashrep_url, :string)
    add_column(:users, :occupation, :string)
    add_column(:users, :is_trader, :boolean)
  end
end
