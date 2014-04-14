class HeadToHeadChallengesController < AbstractChallengesController
  protected
  def set_challenge_variables
    @head_to_head_challenge = HeadToHeadChallenge.find(params[:id])
    @challenge = @head_to_head_challenge.challenge
    flash[:notice] = t("head_to_head_challenge.start")
    super
  end

  def create_user_challenge
    user_challenge = UserChallenge.create(challenge: @challenge, user:current_user, head_to_head_challenge: @head_to_head_challenge)
    track_activity(@head_to_head_challenge, "start")
  end

  def find_user_challenge
    @user_challenge = UserChallenge.where(challenge: Challenge.find(session[:challenge]), user: current_user, head_to_head_challenge: @head_to_head_challenge).last
  end
end
