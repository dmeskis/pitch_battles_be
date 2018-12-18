class CreateKlasses < ActiveRecord::Migration[5.2]
  def change
    create_table :klasses do |t|
      t.string :name
      t.string :class_key

      t.timestamps
    end
  end
end
