class IncorrectHeadToHeadChallengeAnswerHandler < HeadToHeadChallengeAnswerHandler
  def initialize(session, current_user, user_challenge, skill)
    super(session, current_user, user_challenge, skill)
  end

  def handle!
    decrease_skill!
    reset_streak!
    update_user_challenge!
    finish if finished
    super
  end

  def finish
    @head_to_head_challenge.check_finish
  end

  def update_user_challenge!
    super
    user_challenge.update_attributes(amount_fail: user_challenge.amount_fail + 1)
  end

  def get_notice
    I18n.t("answer.wrong")
  end
end
