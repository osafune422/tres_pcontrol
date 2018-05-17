class AddauthorityToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :authority, :integer
    add_column :users, :password_digest, :string
    remove_column :users, :password, :string
  end
end
