class AnswerHandler
  attr_reader :session, :user, :answer_is_correct

  STANDARD_POINT_AMOUNT = 1
  STANDARD_STREAK_AMOUNT = 1

  def initialize(session, current_user)
    @user = current_user
    @session = session
  end

  def reset_challenge
    session.delete(:damage)
    session.delete(:start)
    session.delete(:challenge)
  end

  def reset_streak
    session[:streak] = 0
  end

  def decrease_damage
    if session[:damage] && session[:damage] > 0
      session[:damage] = session[:damage].to_i - 1
    end
  end

  def increase_damage
    session[:damage] = session[:damage].to_i + 1
  end

  def increase_streak(value=1)
    session[:streak] =  session[:streak].to_i + value
  end

  def increase_points(value=1)
    user.increase_points(value)
  end

  def decrease_points(value=1)
    user.decrease_points(value)
  end
end

class ChallengeAnswerHandler < AnswerHandler
  include Rails.application.routes.url_helpers

  attr_reader :challenge, :user_challenge

  STANDARD_DEATH_CEILING = 6

  def initialize(session, current_user, user_challenge)
    super(session, current_user)
    @challenge = user_challenge.challenge
    @user_challenge = user_challenge
  end

  def finished
    @finished ||= user_challenge.amount_good + 1  >= challenge.number_of_problems
  end

  def update_user_challenge
    if is_dead || finished
      reset_challenge
    end
  end

  def redirect_path
    if is_dead || finished
      Rails.application.routes.url_helpers.challenges_path
    end
  end

  def is_dead
    session[:damage] && session[:damage] > STANDARD_DEATH_CEILING
  end
end

class CorrectChallengeAnswerHandler < ChallengeAnswerHandler
  def initialize(session, current_user, user_challenge)
    super(session, current_user, user_challenge)
  end

  def handle
    increase_points(challenge.bonus) if finished
    increase_points(AnswerHandler::STANDARD_POINT_AMOUNT)
    increase_streak(AnswerHandler::STANDARD_STREAK_AMOUNT)
    decrease_damage
  end

  def update_user_challenge
    super
    user_challenge.update_attributes(amount_good: user_challenge.amount_good + 1)
  end

  def get_notice
    return I18n.t("challenge.finished", bonus: challenge.bonus) if finished
    I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
  end


end

class IncorrectChallengeAnswerHandler < ChallengeAnswerHandler
  def initialize(session, current_user, user_challenge)
    super(session, current_user, user_challenge)
  end

  def handle
    increase_damage
    reset_streak
    update_user_challenge
  end

  def update_user_challenge
    super
    user_challenge.update_attributes(success: false) if is_dead
    user_challenge.update_attributes(amount_fail: user_challenge.amount_fail + 1)
  end

  def get_notice
    return I18n.t("answer.dead") if is_dead
    I18n.t("answer.wrong")
  end
end

class PracticeAnswerHandler < AnswerHandler
  def initialize(session, current_user)
    super(session, current_user)
  end

  def redirect_path
    Rails.application.routes.url_helpers.practice_path
  end
end

class CorrectPracticeAnswerHandler < PracticeAnswerHandler
  def initialize(session, current_user)
    super(session, current_user)
  end

  def handle
    increase_points AnswerHandler::STANDARD_POINT_AMOUNT
    increase_streak AnswerHandler::STANDARD_STREAK_AMOUNT
  end

  def get_notice
    I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
  end
end

class IncorrectPracticeAnswerHandler < PracticeAnswerHandler
  def initialize(session, current_user)
    super(session, current_user)
  end

  def handle
    reset_streak
  end

  def get_notice
    I18n.t("answer.wrong")
  end
end

class AnswerHandlerFactory

end
