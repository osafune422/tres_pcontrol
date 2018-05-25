class CreateActualworks < ActiveRecord::Migration[5.2]
  def change
    create_table :actualworks do |t|
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.time :ordistart
      t.time :ordifinish
      t.integer :attendtime
      t.integer :overtime
      t.integer :flex
      t.integer :flontflex
      t.integer :payovertime

      t.timestamps
    end
  end
end
