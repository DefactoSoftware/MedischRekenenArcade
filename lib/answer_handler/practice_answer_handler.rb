class PracticeAnswerHandler < AnswerHandler
  def initialize(session, current_user)
    super(session, current_user)
  end

  def redirect_path
    Rails.application.routes.url_helpers.practice_path
  end
end
