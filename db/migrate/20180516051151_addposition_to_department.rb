class AddpositionToDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :position, :string
  end
end
