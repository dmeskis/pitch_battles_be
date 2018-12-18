class CreateJoinTableKlassesGames < ActiveRecord::Migration[5.2]
  def change
    create_join_table :klasses, :games do |t|
      # t.index [:klass_id, :game_id]
      # t.index [:game_id, :klass_id]
    end
  end
end
