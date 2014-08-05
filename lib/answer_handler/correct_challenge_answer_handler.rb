class CorrectChallengeAnswerHandler < ChallengeAnswerHandler
  def initialize(session, current_user, user_challenge, skill)
    super(session, current_user, user_challenge, skill)
  end

  def handle!
    increase_skill!
    increase_points!(AnswerHandler::STANDARD_POINT_AMOUNT)
    increase_streak!(AnswerHandler::STANDARD_STREAK_AMOUNT)
    decrease_damage!
    update_user_challenge!
    finish if finished
    super
  end

  def update_user_challenge!
    super
    user_challenge.update_attributes(
      amount_good: user_challenge.amount_good + 1)
  end

  def finish
    increase_points!(user_challenge.challenge.bonus)
    user_challenge.update_attributes(success: true)
    challenge_set_completion_badge
  end

  def get_notice
    return I18n.t("challenge.finished", bonus: challenge.bonus) if finished
    I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
  end
end
