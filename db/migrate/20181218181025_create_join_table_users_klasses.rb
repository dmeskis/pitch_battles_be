class CreateJoinTableUsersKlasses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_klasses do |t|
      t.references :user, foreign_key: true
      t.references :klass, foreign_key: true
      t.timestamps
    end
  end
end
