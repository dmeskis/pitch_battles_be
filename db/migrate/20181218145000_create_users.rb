class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name, limit: 32
      t.string :last_name, limit: 32
      t.integer :role, default: 0
      t.string :password_digest
      t.integer :avatar, default: 1

      t.timestamps
    end
  end
end
