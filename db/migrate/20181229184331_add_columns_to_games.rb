class AddColumnsToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :level_one_perfect, :boolean
    add_column :games, :level_two_perfect, :boolean
    add_column :games, :level_three_perfect, :boolean
    add_column :games, :level_four_perfect, :boolean
    add_column :games, :all_perfect, :boolean
  end
end
