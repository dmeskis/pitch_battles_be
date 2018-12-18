class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :total_duration
      t.integer :level_one_duration
      t.integer :level_two_duration
      t.integer :level_three_duration
      t.integer :level_four_duration
      t.integer :remaining_life
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
