class HomeController < ApplicationController
  def index
    if !current_user.guest?
      highscore_lb = RedisLeaderboard.get
      @scores = highscore_lb.ranked_in_list(user_group_users, sort_by: :rank).first(10)
      challenges = current_user.user_challenges
      @last_challenge = challenges.last.challenge if !challenges.empty?
      @last_badge = current_user.badges.last
    end
  end

  private
  def user_group_users
    User.where(user_group: current_user.user_group).map(&:id)
  end
end
