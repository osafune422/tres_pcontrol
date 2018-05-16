class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :number
      t.string :password
      t.text :address
      t.string :department
      t.string :position

      t.timestamps
    end
  end
end
