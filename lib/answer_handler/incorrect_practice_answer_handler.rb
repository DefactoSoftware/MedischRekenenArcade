class IncorrectPracticeAnswerHandler < PracticeAnswerHandler
  def initialize(session, current_user, skill)
    super(session, current_user, skill)
  end

  def handle!
    decrease_skill!
    reset_streak!
    super
  end

  def get_notice
    I18n.t("answer.wrong")
  end
end
