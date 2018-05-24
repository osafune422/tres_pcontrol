class AddPaidholiToAttend < ActiveRecord::Migration[5.2]
  def change
    add_column :attends, :paidholi_sum, :date
  end
end
