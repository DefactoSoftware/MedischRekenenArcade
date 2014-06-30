class IncorrectChallengeAnswerHandler < ChallengeAnswerHandler
  def initialize(session, current_user, user_challenge, skill)
    super(session, current_user, user_challenge, skill)
  end

  def handle!
    decrease_skill!
    increase_damage!
    reset_streak!
    dead?
    update_user_challenge!
    super
  end

  def update_user_challenge!
    super
    user_challenge.update_attributes(success: false) if dead?
    user_challenge.update_attributes(
      amount_fail: user_challenge.amount_fail + 1)
  end

  def get_notice
    return I18n.t("answer.dead") if dead?
    I18n.t("answer.wrong")
  end
end
