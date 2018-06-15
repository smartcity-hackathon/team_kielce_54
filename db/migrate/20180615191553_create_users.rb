class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :username, null: false
    end

		add_index :users, :username, unique: true
		add_index :users, :email, unique: true
  end
end
