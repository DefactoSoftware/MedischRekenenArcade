class ChallengeAnswerHandler < AnswerHandler
  attr_reader :challenge, :user_challenge

  STANDARD_DEATH_CEILING = 6

  def initialize(session, current_user, user_challenge, skill)
    super(session, current_user, skill)
    @challenge = user_challenge.challenge
    @user_challenge = user_challenge
  end

  def handle!
    super
  end

  def finished
    @finished ||= user_challenge.amount_good  >= challenge.number_of_problems
  end

  def is_dead
    @dead ||= session.damage && session.damage > STANDARD_DEATH_CEILING
  end

  def update_user_challenge!
    if is_dead || finished
      reset_challenge!
    end
  end

  def redirect_path(problem)
    if is_dead || finished
      Rails.application.routes.url_helpers.challenges_path
    else
      Rails.application.routes.url_helpers.challenge_path(challenge.name)
    end
  end
end
