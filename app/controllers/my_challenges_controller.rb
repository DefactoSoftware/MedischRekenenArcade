class MyChallengesController < ApplicationController
  before_action :authenticate_user!
  def index
    @head_to_head_challenges = current_user.head_to_head_challenges
    @normal_challenges = current_user.normal_challenges
  end

  def show
    @head_to_head_challenge = HeadToHeadChallenge.find(params[:id])
  end
end
