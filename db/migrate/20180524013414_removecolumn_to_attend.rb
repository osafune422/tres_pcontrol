class RemovecolumnToAttend < ActiveRecord::Migration[5.2]
  def change
    remove_column :attends, :paidholi_sum, :date
  end
end
