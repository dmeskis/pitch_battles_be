class AddKlassIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :users, :klasses
  end
end
