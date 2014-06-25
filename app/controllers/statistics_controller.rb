class StatisticsController < ApplicationController
  before_action :authenticate_user!
  def index
    @challenge_sets = ChallengeSet.where(locked: false)
                                  .order("NAME ASC")
    @user = User.find(params[:user_id])
    @badges = @user.badges
  end
end
