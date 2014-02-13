class CorrectPracticeAnswerHandler < PracticeAnswerHandler
  def initialize(session, current_user, skill)
    super(session, current_user, skill)
  end

  def handle!
    increase_skill!
    increase_points! AnswerHandler::STANDARD_POINT_AMOUNT
    increase_streak! AnswerHandler::STANDARD_STREAK_AMOUNT
    super
  end

  def get_notice
    I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
  end
end

class IncorrectPracticeAnswerHandler < PracticeAnswerHandler
  def initialize(session, current_user, skill)
    super(session, current_user, skill)
  end

  def handle!
    decrease_skill!
    reset_streak!
  end

  def get_notice
    I18n.t("answer.wrong")
  end
end
