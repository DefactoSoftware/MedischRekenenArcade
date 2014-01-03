class CorrectPracticeAnswerHandler < PracticeAnswerHandler
  def initialize(session, current_user)
    super(session, current_user)
  end

  def handle!
    increase_points! AnswerHandler::STANDARD_POINT_AMOUNT
    increase_streak! AnswerHandler::STANDARD_STREAK_AMOUNT
  end

  def get_notice
    I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
  end
end

class IncorrectPracticeAnswerHandler < PracticeAnswerHandler
  def initialize(session, current_user)
    super(session, current_user)
  end

  def handle!
    reset_streak!
  end

  def get_notice
    I18n.t("answer.wrong")
  end
end
