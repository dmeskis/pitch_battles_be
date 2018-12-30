require 'rails_helper'

describe 'badge analysis integration spec', :type => :request do
  before :each do
    @badge_2 = create(:badge, id: 2, name: "play 5 games", description: "Play five games." )
    @badge_3 = create(:badge, id: 3, name: "level one: completed", description: "Complete level one.")
    @badge_4 = create(:badge, id: 4, name: "level one: perfect", description: "Complete level one without losing any lives.")
    @badge_6 = create(:badge, id: 6, name: "level two: completed", description: "Complete level two.")
    @badge_7 = create(:badge, id: 7, name: "level two: perfect", description: "Complete level two without losing any lives." )
    @badge_9 = create(:badge, id: 9, name: "level three: completed", description: "Complete level three." )
    @badge_11 = create(:badge, id: 11, name: "level three: perfect", description: "Complete level three without losing any lives." )
    @badge_12 = create(:badge, id: 12, name: "level four: completed", description: "Complete level four." )
    @badge_14 = create(:badge, id: 14, name: "level four: perfect", description: "Complete level four without losing any lives." )
    @badge_1 = create(:badge, id: 1, name: "all levels: perfect", description: "Complete all levels without losing any lives." )
    @badge_5 = create(:badge, id: 5, name: "play 10 games", description: "Play ten games." )
    @badge_8 = create(:badge, id: 8, name: "play 20 games", description: "Play twenty games.")
    @badge_10 = create(:badge, id: 10, name: "play 50 games", description: "Play fifty games." )
    @badge_13 = create(:badge, id: 13, name: "play 100 games", description: "Play one-hundred games." )
    @badge_15 = create(:badge, id: 15, name: "play 200 games", description: "Play two-hundred games." )
    @badge_16 = create(:badge, id: 16, name: "play 500 games", description: "Play five-hundred games." )
    @badge_17 = create(:badge, id: 17, name: "play 1000 games", description: "Play one-thousand games." )
  end
  it 'can properly analyze badges' do
    # Log in user and retrieve key
    user = User.new(email: 'test@mail.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'Bob',
      last_name: 'Ross',
      role: 0)
    user.save

    body = {
    email: User.first.email,
    password: 'password'
    }

    post '/login', :params => body

    key = JSON.parse(response.body)["access_token"]

    # Post a user game

    patch_body = {              
        perfectScores: { one: true, two: true, three: true, four: false, all: false },
        times: { one: 11111, two: 22222, three: 33333, four: 44444, all: 55555 }
    }

    post "/api/v1/games", :params => patch_body, :headers => {'AUTHORIZATION': "bearer #{key}"}
    user = User.find(user.id)
    expect(user.level_one_fastest_time).to eq(11111)
    expect(user.level_two_fastest_time).to eq(22222)
    expect(user.level_three_fastest_time).to eq(33333)
    expect(user.level_four_fastest_time).to eq(44444)
    expect(user.total_fastest_time).to eq(55555)
    expect(user.badges).to include([@badge_3,
                                    @badge_4,
                                    @badge_6,
                                    @badge_7,
                                    @badge_9,
                                    @badge_12,
                                    ])
  end
  
end