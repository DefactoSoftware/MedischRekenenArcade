class GameSession
  def initialize(session)
    @session = session
  end

  def streak
    @session[:streak]
  end

  def damage
    @session[:damage]
  end

  def start_time
    @session[:start_time]
  end

  def challenge_id
    @session[:challenge_id]
  end

  def reset_challenge!
    @session.delete(:damage)
    @session.delete(:start)
    @session.delete(:challenge)
  end

  def reset_streak!
    streak = 0
    @session[:streak] = 0
  end

  def decrease_damage!
    if @session[:damage] && @session[:damage] > 0
      @session[:damage] = @session[:damage].to_i - 1
    end
  end

  def increase_damage!
    @session[:damage] = @session[:damage].to_i + 1
  end

  def increase_streak!(value=1)
    @session[:streak] =  @session[:streak].to_i + value
  end
end

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

class ChallengeAnswerHandler < AnswerHandler
  attr_reader :challenge, :user_challenge

  STANDARD_DEATH_CEILING = 6

  def initialize(session, current_user, user_challenge)
    super(session, current_user)
    @challenge = user_challenge.challenge
    @user_challenge = user_challenge
  end

  def finished
    @finished ||= user_challenge.amount_good  >= challenge.number_of_problems
  end

  def is_dead
    @dead ||= session.damage && session.damage > STANDARD_DEATH_CEILING
  end

  def update_user_challenge!
    if is_dead || finished
      reset_challenge!
    end
  end

  def redirect_path
    if is_dead || finished
      Rails.application.routes.url_helpers.challenges_path
    else
      Rails.application.routes.url_helpers.challenge_path(challenge.name)
    end
  end


end

class CorrectChallengeAnswerHandler < ChallengeAnswerHandler
  def initialize(session, current_user, user_challenge)
    super(session, current_user, user_challenge)
  end

  def handle!
    increase_points!(AnswerHandler::STANDARD_POINT_AMOUNT)
    increase_streak!(AnswerHandler::STANDARD_STREAK_AMOUNT)
    decrease_damage!
    update_user_challenge!
    finish if finished
  end

  def update_user_challenge!
    super
    user_challenge.update_attributes(amount_good: user_challenge.amount_good + 1)
  end

  def finish
    increase_points!(user_challenge.challenge.bonus)
    user_challenge.update_attributes(success: true)
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

  def handle!
    increase_damage!
    reset_streak!
    is_dead
    update_user_challenge!
  end

  def update_user_challenge!
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

class AnswerHandlerFactory
  def initialize(session, answer_is_correct, user)
    @session = session
    @answer_is_correct = answer_is_correct
    @user = user
  end

  def build
    if @session[:challenge]
      if @answer_is_correct
        CorrectChallengeAnswerHandler.new(@session, @user, user_challenge)
      else
        IncorrectChallengeAnswerHandler.new(@session, @user, user_challenge)
      end
    else
      if @answer_is_correct
        CorrectPracticeAnswerHandler.new(@session, @user)
      else
        IncorrectPracticeAnswerHandler.new(@session, @user)
      end
    end
  end

  private
  def user_challenge
    UserChallenge.where(challenge: Challenge.find(@session[:challenge]), user: @user).last
  end
end
