class GuestAnswerHandler < AnswerHandler
  def initialize(session, current_user, skill)
    super(session, current_user, skill)
  end

  def redirect_path(problem)
    Rails.application.routes.url_helpers.practice_path + "?problem=#{problem.class.name}"
  end
end

