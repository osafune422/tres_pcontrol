class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.date :start
      t.date :finish
      t.text :place
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
