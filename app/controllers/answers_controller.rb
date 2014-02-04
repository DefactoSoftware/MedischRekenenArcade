require 'answer_handler'

class AnswersController < ApplicationController
  feedback_types = %(conversion rounding)

  before_action :authenticate_user!
  def create
    @answer = Answer.new(value: parse_value(answer_parameters[:value]), problem_id: answer_parameters[:problem_id])
    @answer.user = current_user
    @answer.feedback = I18n.t("answer.feedback.correct")

    handler = AnswerHandlerFactory.new(session, eval_answer(@answer), current_user, @answer.problem.skill).build

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
    params.require(:answer).permit(:problem_id, :value)
  end

  def parse_value(value)
    value.gsub(',', '.')
  end

  def eval_answer(answer)
    problem_result = Problem.find(answer_parameters[:problem_id]).get_result
    if answer.value.round(2) == problem_result.round(2)
      true
    else
      eval_answer_deep
    end
  end

  def eval_answer_deep
    problem_result = Problem.find(answer_parameters[:problem_id]).get_result
    if (@answer.value / 10).round(2) == problem_result.round(2) || (@answer.value / 100).round(2) == problem_result.round(2) || (@answer.value / 1000).round(2) == problem_result.round(2)
      @answer.feedback = I18n.t("answer.feedback.conversion")
      false
    elsif (@answer.value * 10).round(2) == problem_result.round(2) || (@answer.value * 100).round(2) == problem_result.round(2) || (@answer.value * 1000).round(2) == problem_result.round(2)
      @answer.feedback = I18n.t("answer.feedback.conversion")
      false
    elsif @answer.value == problem_result || ((@answer.value - 1.0)..(@answer.value + 1.0)).include?(problem_result)
      @answer.feedback = I18n.t("answer.feedback.rounding")
      false
    else
      false
    end
  end
end
