class RemoveRemainingLifeFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :remaining_life, :integer
  end
end
