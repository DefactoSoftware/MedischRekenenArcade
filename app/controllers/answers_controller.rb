require 'answer_handler'

class AnswersController < ApplicationController
  before_action :authenticate_user!
  def create
    answer = Answer.new(answer_parameters)
    answer.user = current_user

    if session[:challenge]
      if eval_answer(answer)
        handler = CorrectChallengeAnswerHandler.new(session, current_user, UserChallenge.where(challenge: Challenge.find(session[:challenge]), user: current_user).last)
      else
        handler = IncorrectChallengeAnswerHandler.new(session, current_user, UserChallenge.where(challenge: Challenge.find(session[:challenge]), user: current_user).last)
      end
    else
      if eval_answer(answer)
        handler = CorrectPracticeAnswerHandler.new(session, current_user)
      else
        handler = IncorrectPracticeAnswerHandler.new(session, current_user)
      end
    end

    redirection_path = handler.redirect_path
    notice = handler.get_notice
    handler.handle

    if answer.save!
      redirect_to redirection_path ? redirection_path : request.referer, notice: notice
    else
      redirect_to redirection_path ? redirection_path : request.referer, error: t("answer.save.error")
    end
  end

  private
  def answer_parameters
    params.require(:answer).permit(:problem_id, :value)
  end

  def eval_answer(answer)
    answer.value.round(2) == Problem.find(answer_parameters[:problem_id]).get_result.round(2)
  end
end
