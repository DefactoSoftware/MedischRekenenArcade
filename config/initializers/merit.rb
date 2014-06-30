# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongo_mapper and :mongoid
  config.orm = :active_record

  # Define :user_model_name. This model will be used to grand badge if no :to option is given. Default is "User".
  config.user_model_name = "User"

  # Define :current_user_method. Similar to previous option. It will be used to retrieve :user_model_name object if no :to option is given. Default is "current_#{user_model_name.downcase}".
  config.current_user_method = "current_user"
end

# Create application badges (uses https://github.com/norman/ambry)
Merit::Badge.create!(
  {
    id: 1,
    name: 'night_owl',
    image: "badges/NightOwl.png",
    description: 'night_owl.description'
  }
)
Merit::Badge.create!(
  {
    id: 2,
    name: 'quick_n_dirty_a',
    image: "badges/Quick_N_Dirty_A.png",
    description: 'quick_n_dirty_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 3,
    name: 'quick_n_dirty_b',
    image: "badges/Quick_N_Dirty_B.png",
    description: 'quick_n_dirty_b.description'
  }
)
Merit::Badge.create!(
  {
    id: 4,
    name: 'quick_n_dirty_c',
    image: "badges/Quick_N_Dirty_C.png",
    description: 'quick_n_dirty_c.description'
  }
)
Merit::Badge.create!(
  {
    id: 5,
    name: 'streak_master_a',
    image: "badges/Streak_Master_A.png",
    description: 'streak_master_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 6,
    name: 'streak_master_b',
    image: "badges/Streak_Master_B.png",
    description: 'streak_master_b.description'
  }
)
Merit::Badge.create!(
  {
    id: 7,
    name: 'streak_master_c',
    image: "badges/Streak_Master_C.png",
    description: 'streak_master_b.description'
  }
)
Merit::Badge.create!(
  {
    id: 8,
    name: 'questions_answered_a',
    image: "badges/Questions_Answered_A.png",
    description: 'questions_answered_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 9,
    name: 'questions_answered_b',
    image: "badges/Questions_Answered_B.png",
    description: 'questions_answered_b.description'
  }
)
Merit::Badge.create!(
  {
    id: 10,
    name: 'questions_answered_c',
    image: "badges/Questions_Answered_C.png",
    description: 'questions_answered_c.description'
  }
)
Merit::Badge.create!(
  {
    id: 11,
    name: 'rise_and_shine',
    image: "badges/Rise_N_Shine.png",
    description: 'rise_and_shine.description'
  }
)
Merit::Badge.create!(
  {
    id: 12,
    name: 'night_crawler',
    image: "badges/NightCrawler.png",
    description: 'night_crawler.description'
  }
)
Merit::Badge.create!(
  {
    id: 13,
    name: 'challenger_rank_up',
    image: "badges/ChallengerRankUp.png",
    description: 'challenger_rank_up.description'
  }
)
Merit::Badge.create!(
  {
    id: 14,
    name: 'challenge_champion_a',
    image: "badges/Challenges_wk1.png",
    description: 'challenge_champion_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 15,
    name: 'challenge_champion_b',
    image: "badges/Challenges_wk2.png",
    description: 'challenge_champion_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 16,
    name: 'challenge_champion_c',
    image: "badges/Challenges_wk3.png",
    description: 'challenge_champion_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 17,
    name: 'challenge_champion_d',
    image: "badges/Challenges_wk4.png",
    description: 'challenge_champion_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 18,
    name: 'enthusiast_a',
    image: "badges/Fanatic-Enthusiast_A.png",
    description: 'enthusiast_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 19,
    name: 'enthusiast_b',
    image: "badges/Fanatic-Enthusiast_B.png",
    description: 'enthusiast_b.description'
  }
)
Merit::Badge.create!(
  {
    id: 20,
    name: 'enthusiast_c',
    image: "badges/Fanatic-Enthusiast_C.png",
    description: 'enthusiast_c.description'
  }
)
Merit::Badge.create!(
  {
    id: 21,
    name: 'cold_feet_a',
    image: "badges/Cold_Feet_A.png",
    description: 'cold_feet_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 22,
    name: 'cold_feet_b',
    image: "badges/Cold_Feet_B.png",
    description: 'cold_feet_a.description'
  }
)
Merit::Badge.create!(
  {
    id: 23,
    name: 'cold_feet_c',
    image: "badges/Cold_Feet_C.png",
    description: 'cold_feet_c.description'
  }
)
Merit::Badge.create!(
  {
    id: 24,
    name: 'particioner',
    image: "badges/Particioner.png",
    description: 'particioner.description'
  }
)
Merit::Badge.create!(
  {
    id: 25,
    name: 'narcissist',
    image: "badges/Narcissist.png",
    description: 'narcissist.description'
  }
)
Merit::Badge.create!(
  {
    id: 26,
    name: 'practicer',
    image: "badges/Practicer.png",
    description: 'practicer.description'
  }
)
Merit::Badge.create!(
  {
    id: 27,
    name: 'speed_racer',
    image: "badges/SpeedRacer.png",
    description: 'speed_racer.description'
  }
)
Merit::Badge.create!(
  {
    id: 28,
    name: 'winner',
    image: "badges/Winner.png",
    description: 'winner.description'
  }
)
Merit::Badge.create!(
  {
    id: 29,
    name: 'perfectionist',
    image: "badges/Perfectionist.png",
    description: 'perfectionist.description'
  }
)
