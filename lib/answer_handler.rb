class AnswerHandler
  STANDARD_POINT_AMOUNT = 1
  STANDARD_STREAK_AMOUNT = 1

  def reset_streak
    @session[:streak] = 0
  end

  def decrease_damage
    if @session[:damage] && @session[:damage] > 0
      @session[:damage] = @session[:damage].to_i - 1
    end
  end

  def increase_damage
    @session[:damage] = @session[:damage].to_i + 1
  end

  def increase_streak(value)
    @session[:streak] =  @session[:streak].to_i + value
  end

  def increase_points(value)
    Point.increase(value, @user)
  end

  def decrease_points(value)
    Point.decrease(value, @user)
  end

end

class ChallengeSession < AnswerHandler
  STANDARD_DEATH_CEILING = 6

  def initialize(answer_is_correct, session, current_user)
    @user=current_user
    @answer_is_correct = answer_is_correct
    @challenge = Challenge.find(session[:challenge])
    @session = session
    @userchallenge = UserChallenge.where(challenge: @challenge, user: current_user).last
    @finished = @userchallenge.amount_good + 1  >= @challenge.number_of_problems if @answer_is_correct
  end

  def handle
    distribute_points_and_damage
    update_user_challenge
  end

  def distribute_points_and_damage
    if @finished
      increase_points(@challenge.bonus)
    end

    if @answer_is_correct
      increase_points(AnswerHandler::STANDARD_POINT_AMOUNT)
      increase_streak(AnswerHandler::STANDARD_STREAK_AMOUNT)
      decrease_damage
    else
      increase_damage
      reset_streak
    end
  end

  def update_user_challenge
    if @answer_is_correct
      @userchallenge.update_attributes(amount_good: @userchallenge.amount_good + 1)
    else
      @userchallenge.update_attributes(amount_fail: @userchallenge.amount_fail + 1)
    end

    if is_dead
      @userchallenge.update_attributes(success: false)
    end

    if is_dead || @finished
      reset_challenge
    end
  end

  def get_path
    if is_dead || @finished
      challenges_path
    end
  end

  def get_notice
    if @finished
      return I18n.t("challenge.finished", bonus: @challenge.bonus)
    end

    if is_dead
      return I18n.t("answer.dead")
    end

    if @answer_is_correct
      I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
    else
      I18n.t("answer.wrong")
    end
  end

  def is_dead
    if !@answer_is_correct
      @session[:damage] && @session[:damage] > STANDARD_DEATH_CEILING
    end
  end
end

class PracticeSession < AnswerHandler
 def initialize(answer_is_correct, session, current_user)
    @user=current_user
    @answer_is_correct = answer_is_correct
    @session = session
  end

  def handle
    distribute_points
  end

  def distribute_points
    if @answer_is_correct
      increase_points AnswerHandler::STANDARD_POINT_AMOUNT
      increase_streak AnswerHandler::STANDARD_STREAK_AMOUNT
    else
      reset_streak
    end
  end

  def get_path

  end

  def get_notice
    if @answer_is_correct
      I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
    else
      I18n.t("answer.wrong")
    end
  end
end
