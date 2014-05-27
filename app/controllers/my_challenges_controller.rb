class MyChallengesController < ApplicationController
  before_action :authenticate_user!
  def index
    @challenge_sets = ChallengeSet.where(locked:false).order("NAME ASC")
    @head_to_head_challenges = current_user.head_to_head_challenges
    @normal_challenges = current_user.normal_challenges
    @user = current_user
  end

  def show
    @head_to_head_challenge = HeadToHeadChallenge.find(params[:id])
  end
end
