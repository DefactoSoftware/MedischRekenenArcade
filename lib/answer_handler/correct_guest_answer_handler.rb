class CorrectGuestAnswerHandler < GuestAnswerHandler
  def initialize(session, current_user, skill)
    super(session, current_user, skill)
  end

  def handle!
    increase_streak! AnswerHandler::STANDARD_STREAK_AMOUNT
  end

  def get_notice
    I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
  end
end
