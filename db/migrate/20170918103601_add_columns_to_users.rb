class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :picture, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dob, :date
    add_column :users, :phone_number, :string
    add_reference :users, :role, foreign_key: true
  end
end
