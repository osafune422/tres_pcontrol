class AddDateToAttend < ActiveRecord::Migration[5.2]
  def change
    add_column :attends, :date, :date
  end
end
