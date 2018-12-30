namespace :db do
  desc 'seeds all badges' do
    task :seed_badges => :environment do
      Badge.delete_all
      Badge.create!(id: 1, name: "play 5 games", description: "Play five games." )
      Badge.create!(id: 2, name: "level one: completed", description: "Complete level one.")
      Badge.create!(id: 3, name: "level one: perfect", description: "Complete level one without losing any lives.")
      Badge.create!(id: 4, name: "level two: completed", description: "Complete level two.")
      Badge.create!(id: 6, name: "level two: perfect", description: "Complete level two without losing any lives." )
      Badge.create!(id: 7, name: "level three: completed", description: "Complete level three." )
      Badge.create!(id: 9, name: "level three: perfect", description: "Complete level three without losing any lives." )
      Badge.create!(id: 11, name: "level four: completed", description: "Complete level four." )
      Badge.create!(id: 12, name: "level four: perfect", description: "Complete level four without losing any lives." )
      Badge.create!(id: 14, name: "all levels: perfect", description: "Complete all levels without losing any lives." )
      Badge.create!(id: 5, name: "play 10 games", description: "Play ten games." )
      Badge.create!(id: 8, name: "play 20 games", description: "Play twenty games.")
      Badge.create!(id: 10, name: "play 50 games", description: "Play fifty games." )
      Badge.create!(id: 13, name: "play 100 games", description: "Play one-hundred games." )
      Badge.create!(id: 15, name: "play 200 games", description: "Play two-hundred games." )
      Badge.create!(id: 16, name: "play 500 games", description: "Play five-hundred games." )
      Badge.create!(id: 17, name: "play 1000 games", description: "Play one-thousand games." )
    end
  end
end
