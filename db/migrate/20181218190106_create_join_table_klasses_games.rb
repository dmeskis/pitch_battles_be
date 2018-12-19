class CreateJoinTableKlassesGames < ActiveRecord::Migration[5.2]
  def change
    create_table :klass_games do |t|
      t.references :klass, foreign_key: true
      t.references :games, foreign_key: true
      t.timestamps
    end
  end
end
