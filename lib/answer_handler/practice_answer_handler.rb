class PracticeAnswerHandler < AnswerHandler
  def initialize(session, current_user)
    super(session, current_user)
  end

  def redirect_path(problem)
    Rails.application.routes.url_helpers.practice_path + "?problem=#{problem.class.name}"
  end
end
