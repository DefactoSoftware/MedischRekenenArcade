require 'answer_handler'

class AnswersController < ApplicationController
  before_action :authenticate_user!
  def create
    @answer = Answer.new(user_challenge_id: answer_parameters[:user_challenge_id], value: parse_value(answer_parameters[:value]), problem_id: answer_parameters[:problem_id], user: current_user)

    handler = AnswerHandlerFactory.new(session, @answer.correct?, current_user, @answer.problem.skill).build

    handler.handle!
    redirection_path = handler.redirect_path(@answer.problem)

    notice = handler.get_notice

    if @answer.save!
      redirect_to redirection_path, notice: notice
    else
      redirect_to redirection_path, error: t("answer.save.error")
    end
  end

  private
  def answer_parameters
    params.require(:answer).permit(:problem_id, :value, :user_challenge_id)
  end

  def parse_value(value)
    value.gsub(',', '.')
  end
end



