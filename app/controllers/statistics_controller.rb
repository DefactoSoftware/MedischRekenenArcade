class StatisticsController < ApplicationController
  before_action :authenticate_user!
  def index
    @challenge_sets = ChallengeSet.where(locked:false)
    @user = User.find(params[:user_id])
    @badges = @user.badges
  end
end
