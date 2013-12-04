class LeaderboardsController < ApplicationController
  before_action :authenticate_user!
  def show

  end

  def index
    highscore_lb = Leaderboard.new('highscores')
    @top_scores = highscore_lb.leaders(10)
    @user_group_scores = highscore_lb.ranked_in_list(user_group_users, sort_option: :score).reverse
    @around_me_scores = highscore_lb.around_me(current_user.id)
  end

  private
  def user_group_users
    users = User.where(user_group: current_user.user_group)
    user_ids = users.map do |user|
      user.id
    end
  end
end
