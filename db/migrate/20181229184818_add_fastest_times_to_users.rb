class AddFastestTimesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :level_one_fastest_time, :integer, :default => 0
    add_column :users, :level_two_fastest_time, :integer, :default => 0
    add_column :users, :level_three_fastest_time, :integer, :default => 0
    add_column :users, :level_four_fastest_time, :integer, :default => 0
    add_column :users, :total_fastest_time, :integer, :default => 0
    add_column :users, :total_games_played, :integer, :default => 0
  end
end
