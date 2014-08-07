class BadgesObserver < ActiveRecord::Observer
  MORNING_START = 5
  AFTERNOON_START = 11
  EVENING_START = 17
  NIGHT_START = 23

  BADGES = {
    night_owl: 1,
    quick_n_dirty_a: 2,
    quick_n_dirty_b: 3,
    quick_n_dirty_c: 4,
    streak_master_a: 5,
    streak_master_b: 6,
    streak_master_c: 7,
    questions_answered_a: 8,
    questions_answered_b: 9,
    questions_answered_c: 10,
    rise_and_shine: 11,
    night_crawler: 12,
    challenger_rank_up: 13,
    challenge_champion_a: 14,
    challenge_champion_b: 15,
    challenge_champion_c: 16,
    challenge_champion_d: 17,
    enthusiast_a: 18,
    enthusiast_b: 19,
    enthusiast_c: 20,
    cold_feet_a: 21,
    cold_feet_b: 22,
    cold_feet_c: 23,
    particioner: 24,
    narcissist: 25,
    practicer: 26,
    speed_racer: 27,
    winner: 28,
    perfectionist: 29
  }

  protected

  def add_badge(badge_id)
    badge = Merit::Badge.find(badge_id)
    unless @badges.include?(badge)
      @user.add_badge(badge_id)
    end
  end
end

# Merit::Badge.create!(
#   {
#     id: 24,
#     name: 'particioner',
#     image: "badges/Particioner.png",
#     description: 'particioner.description'
#   }
# )
# Merit::Badge.create!(
#   {
#     id: 25,
#     name: 'narcissist',
#     image: "badges/Narcissist.png",
#     description: 'narcissist.description'
#   }
# )
# Merit::Badge.create!(
#   {
#     id: 26,
#     name: 'practicer',
#     image: "badges/Practicer.png",
#     description: 'practicer.description'
#   }
# )
# Merit::Badge.create!(
#   {
#     id: 27,
#     name: 'speed_racer',
#     image: "badges/SpeedRacer.png",
#     description: 'speed_racer.description'
#   }
# )
# Merit::Badge.create!(
#   {
#     id: 28,
#     name: 'winner',
#     image: "badges/Winner.png",
#     description: 'winner.description'
#   }
# )
# Merit::Badge.create!(
#   {
#     id: 29,
#     name: 'perfectionist',
#     image: "badges/Perfectionist.png",
#     description: 'perfectionist.description'
#   }
# )
