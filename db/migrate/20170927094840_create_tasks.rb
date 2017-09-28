class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :status, default: false
      t.integer :duration

      t.timestamps
    end
  end
end
