class HeadToHeadChallengesController < AbstractChallengesController
  def create
    head_to_head_challenge = HeadToHeadChallenge.new(
      challenger: current_user,
      challenged_id: head_to_head_challenge_params[:challenged_id],
      challenge_id: head_to_head_challenge_params[:challenge_id]
    )
    if head_to_head_challenge.save!
      redirect_to challenges_path, notice: I18n.t("head_to_head_challenge.save.success")
    else
      redirect_to challenges_path, notice: I18n.t("head_to_head_challenge.save.fail")
    end
  end

  def show
    @head_to_head_challenge = HeadToHeadChallenge.find(params[:id])
    redirect_to my_challenges_path(@head_to_head_challenge) if @head_to_head_challenge.finished?
    super
  end

  protected
  def set_challenge_variables
    @challenge = @head_to_head_challenge.challenge
    flash[:notice] = t("head_to_head_challenge.start")
    super
  end

  def create_user_challenge
    user_challenge = find_user_challenge || UserChallenge.create(user_challenge_params)
    track_activity(@head_to_head_challenge, "start")
  end

  def find_user_challenge
    @user_challenge = @head_to_head_challenge.user_challenges.where(user: current_user).first
  end

  def head_to_head_challenge_params
    params.require(:head_to_head_challenge).permit(:challenged_id, :challenge_id)
  end

  def user_challenge_params
    { challenge: @challenge, user: current_user, head_to_head_challenge: @head_to_head_challenge }
  end

  def calculate_progress
    amount_good = Float(@user_challenge.amount_good + @user_challenge.amount_fail)
    amount_problems = Float(@user_challenge.challenge.number_of_problems)
    @progress = (amount_good / amount_problems) * 100
  end
end
