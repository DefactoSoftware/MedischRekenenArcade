class ChallengesController < AbstractChallengesController
  def index
    reset_challenge
    @challengesets = ChallengeSet.where(locked: false).order("NAME ASC")
  end

  protected
  def set_challenge_variables
    @challenge = Challenge.where(name:params[:id]).last
    flash[:notice] = t("challenge.start")
    super
  end

  def create_user_challenge
    user_challenge = UserChallenge.create(challenge: @challenge, user:current_user)
    track_activity(user_challenge, "start")
  end

  def find_user_challenge
    @user_challenge = UserChallenge.where(challenge: Challenge.find(session[:challenge]), user: current_user).last
  end
end
