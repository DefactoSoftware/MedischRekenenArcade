class LeaderboardsController < ApplicationController
  include RedisLeaderboard
  before_action :authenticate_user!
  def index
    highscore_lb = RedisLeaderboard.get
    @top_scores = highscore_lb.leaders(1)
    @user_group_scores = highscore_lb.ranked_in_list(user_group_users, sort_by: :rank)
    @around_me_scores = highscore_lb.around_me(current_user.id, sort_by: :rank)
  end

  private
  def user_group_users
    User.where(user_group: current_user.user_group).map(&:id)
  end
end
