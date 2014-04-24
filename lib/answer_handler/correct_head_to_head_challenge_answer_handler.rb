class CorrectHeadToHeadChallengeAnswerHandler < HeadToHeadChallengeAnswerHandler
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
    user_challenge.update_attributes(amount_good: user_challenge.amount_good + 1)
  end

  def finish
    if @head_to_head_challenge.check_finish
      @head_to_head_challenge.finished!
    end
    user_challenge.challenge.challenge_set.user_check_completed(@user)
  end

  def get_notice
    return I18n.t("head_to_head_challenge.finished") if finished
    I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
  end
end
