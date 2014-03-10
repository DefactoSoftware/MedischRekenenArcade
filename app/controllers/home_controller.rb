class HomeController < ApplicationController
  def index
    highscore_lb = RedisLeaderboard.get
    @scores = highscore_lb.ranked_in_list(user_group_users, sort_by: :rank).first(10) if !current_user.guest?
    challenges = current_user.user_challenges
    @last_challenge = challenges.last.challenge if !challenges.empty?
    @last_badge = current_user.badges.last
  end

  private
  def user_group_users
    current_user.user_group.users.map(&:id)
  end
end
