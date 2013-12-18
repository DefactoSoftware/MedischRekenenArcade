require 'answer_handler'

class AnswersController < ApplicationController
  before_action :authenticate_user!
  def create
    @answer = Answer.new(answer_parameters)
    @answer.user = current_user

    handler = AnswerHandlerFactory.new(session, eval_answer(@answer), current_user).build

    handler.handle!
    redirection_path = handler.redirect_path
    notice = handler.get_notice


    if @answer.save!
      redirect_to redirection_path, notice: notice
    else
      redirect_to redirection_path, error: t("answer.save.error")
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
