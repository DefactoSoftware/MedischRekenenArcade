class GuestAnswerHandler < AnswerHandler
  def initialize(session, current_user, skill)
    super(session, current_user, skill)
  end

  def get_notice(notice)
    if Answer.where(ip: session.ip).count % 3 == 0
      notice += I18n.t("answer.call_to_register")
    end
    notice
  end

  def redirect_path(problem)
    Rails.application
         .routes
         .url_helpers
         .practice_path + "?problem=#{problem.class.name}"
  end
end
