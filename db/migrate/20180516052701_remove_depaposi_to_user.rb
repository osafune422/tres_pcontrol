class RemoveDepaposiToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :department, :string
    remove_column :users, :position, :string
  end
end
