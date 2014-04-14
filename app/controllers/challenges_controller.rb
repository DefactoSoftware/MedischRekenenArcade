class ChallengesController < AbstractChallengesController
  def index
    reset_challenge
    @challengesets = ChallengeSet.where(locked: false).order("NAME ASC")
  end

  protected
  def set_challenge_variables
    @challenge = Challenge.where(name: params[:id]).last
    flash[:notice] = t("challenge.start")
    super
  end

  def create_user_challenge
    user_challenge = UserChallenge.create(user_challenge_params)
    track_activity(user_challenge, "start")
  end

  def find_user_challenge
    @user_challenge = UserChallenge.where(user_challenge_params).last
  end

  def user_challenge_params
    { challenge: @challenge, user: current_user }
  end
end
