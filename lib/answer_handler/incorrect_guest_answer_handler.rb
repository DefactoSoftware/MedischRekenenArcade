class IncorrectGuestAnswerHandler < GuestAnswerHandler
  def initialize(session, current_user, skill)
    super(session, current_user, skill)
  end

  def handle!
    reset_streak!
  end

  def get_notice
    notice = I18n.t("answer.wrong")
    super(notice)
  end
end
