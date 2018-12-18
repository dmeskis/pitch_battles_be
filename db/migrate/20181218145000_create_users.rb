class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.integer :role
      t.string :password_digest
      t.integer :avatar

      t.timestamps
    end
  end
end
