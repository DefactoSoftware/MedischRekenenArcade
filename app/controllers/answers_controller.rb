class AnswersController < ApplicationController
  before_action :authenticate_user!
  require 'answer_handler'
  def create
    answer = Answer.new(answer_parameters)
    answer.user = current_user

    if session[:challenge]
      handler = ChallengeSession.new(eval_answer(answer), session, current_user, UserChallenge.where(challenge: Challenge.find(session[:challenge]), user: current_user).last)
    else
      handler = PracticeSession.new(eval_answer(answer), session, current_user)
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
