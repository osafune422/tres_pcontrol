class CreateAttends < ActiveRecord::Migration[5.2]
  def change
    create_table :attends do |t|
      t.integer :user_id
      t.time :start
      t.time :finish
      t.string :remark
      t.integer :rest
      t.integer :sum

      t.timestamps
    end
  end
end
