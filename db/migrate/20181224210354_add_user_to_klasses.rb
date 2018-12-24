class AddUserToKlasses < ActiveRecord::Migration[5.2]
  def change
    add_reference :klasses, :teacher, index: true
    add_foreign_key :klasses, :users, column: :teacher_id
  end
end
