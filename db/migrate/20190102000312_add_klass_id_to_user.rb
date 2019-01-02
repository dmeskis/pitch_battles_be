class AddKlassIdToUser < ActiveRecord::Migration[5.2]
  def change
    drop_join_table :users, :klasses, table_name: 'user_klasses'  
    add_column :users, :klass_id, :integer, index: true
    add_foreign_key :users, :klasses, column: :klass_id
  end
end
