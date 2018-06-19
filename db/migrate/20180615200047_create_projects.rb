class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :lat
      t.decimal :lng
      t.text :place
      t.string :budget_type
      t.string :status, null: false, default: 'submitted'
      t.integer :votes_count, null: false, default: 0
      t.integer :category_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_foreign_key :projects, :categories
    add_foreign_key :projects, :users
  end
end
