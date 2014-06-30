class HeadToHeadChallengeAnswerHandler < AnswerHandler
  attr_reader :challenge, :user_challenge

  def initialize(session, current_user, user_challenge, skill)
    super(session, current_user, skill)
    @challenge = user_challenge.challenge
    @user_challenge = user_challenge
    @head_to_head_challenge = user_challenge.head_to_head_challenge
  end

  def handle!
    super
  end

  def finished
    @finished ||= user_challenge.amount_good +
                  user_challenge.amount_fail >=
                  @challenge.number_of_problems
  end

  def update_user_challenge!
    if finished
      reset_challenge!
    end
  end

  def redirect_path(_)
    if finished
      Rails.application
      .routes
      .url_helpers
      .user_challenge_path(@user,
                           @head_to_head_challenge)
    else
      Rails.application
      .routes
      .url_helpers
      .head_to_head_challenge_path(@head_to_head_challenge)
    end
  end
end
