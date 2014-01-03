class AnswerHandler
  attr_reader :session, :user, :answer_is_correct

  STANDARD_POINT_AMOUNT = 1
  STANDARD_STREAK_AMOUNT = 1

  def initialize(session, current_user)
    @user = current_user
    @session = GameSession.new(session)
  end

  def method_missing(method, *args, &block)
    session.send(method, *args, &block)
  end

  def increase_points!(value=1)
    user.increase_points(value)
  end

  def decrease_points!(value=1)
    user.decrease_points(value)
  end
end
