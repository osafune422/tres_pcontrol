class AddPaidholiToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :paidholi_sum, :integer
  end
end
