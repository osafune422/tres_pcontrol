class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.integer :user_id
      t.string :department

      t.timestamps
    end
  end
end
