class AnswersController < ApplicationController
  STANDARD_POINT_AMOUNT = 1
  STANDARD_STREAK_AMOUNT = 1

  def create
    answer = Answer.new(answer_parameters, user: current_user)
    @redirection_path = request.referer
    answer_result = eval_answer(answer)

    if session[:challenge]
      handle_challenge answer_result
    else
      handle_practice answer_result
    end

    distribute_points answer_result

    if answer.save!
      redirect_to @redirection_path, notice: @notice
    else
      redirect_to @redirection_path, error: t("answer.save.error")
    end
  end

  private
  def answer_parameters
    params.require(:answer).permit(:problem_id, :value)
  end

  def handle_practice answer_result
    if answer_result
      @notice = t("answer.correct", points: STANDARD_POINT_AMOUNT)
    else
      @notice = t("answer.wrong")
    end
  end


  def distribute_points answer_result
    if answer_result
      increment_points STANDARD_POINT_AMOUNT
      increment_streak STANDARD_STREAK_AMOUNT
    else
      reset_streak
    end
  end

  def handle_challenge answer_result
    challenge = Challenge.find(session[:challenge])
    userchallenge = UserChallenge.where(challenge: challenge, user:current_user).last
    if answer_result
      userchallenge.update_attributes(amount_good: userchallenge.amount_good + 1)
      @notice = t("answer.correct", points: STANDARD_POINT_AMOUNT)
      if userchallenge.amount_good == challenge.number_of_problems
        userchallenge.update_attributes(success: true)
        reset_challenge
      end
    else
      userchallenge.update_attributes(amount_fail: userchallenge.amount_fail + 1)
      if session[:damage] && session[:damage] > 6
        @notice = t("answer.dead")
        userchallenge.update_attributes(success: false)
        reset_challenge
      else
        @notice = t("answer.wrong")
        increase_damage
      end
    end
  end

  def reset_challenge
    @redirection_path = challenges_path
    session.delete(:damage)
    session.delete(:challenge)
    session.delete(:start)
  end

  def eval_answer answer
    answer.value.round(2) == Problem.find(answer_parameters[:problem_id]).get_result.round(2)
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

  def increment_streak(value=1)
    session[:streak] = session[:streak].to_i + value
  end

  def increment_points(value=1)
    Point.create(user: current_user, amount: value)
  end
end
