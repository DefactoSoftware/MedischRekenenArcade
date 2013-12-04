class AnswersController < ApplicationController
  def create
    answer = Answer.new(answer_parameters)
    if answer.save!
      redirect_to request.referer, notice: check_answer(answer)
    else
      redirect_to request.referer, error: t("answer.save.error")
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
      t("answer.correct", points: 2)
    else
      reset_streak
      t("answer.wrong")
    end
  end

  def eval_answer answer
    answer.value.round(2) == Problem.find(answer_parameters[:problem_id]).get_result.round(2)
  end

  def reset_streak
    session[:streak] = 0
  end

  def increment_streak(value=1)
    session[:streak] = session[:streak].to_i + value
  end

  def increment_points(value=1)
    Point.create(user: current_user, amount: value)
  end
end
