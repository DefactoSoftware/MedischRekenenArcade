class AnswersController < ApplicationController
  def create
    answer = Answer.new(answer_parameters, user: current_user)
    @redirection_path = request.referer
    notice = check_answer(answer)
    if answer.save!
      redirect_to @redirection_path, notice: notice
    else
      redirect_to @redirection_path, error: t("answer.save.error")
    end
  end

  private
  def answer_parameters
    params.require(:answer).permit(:problem_id, :value)
  end

  def check_answer answer
    if eval_answer(answer)
      increment_points 2
      increment_streak 1
      decrease_damage
      t("answer.correct", points: 2)
    else
      reset_streak
      if session[:damage] && session[:damage] > 6
        session[:damage] = 0
        @redirection_path = root_url #will have to be challenge#index later
        t("answer.dead")
      else
        increase_damage
        t("answer.wrong")
      end
    end
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
