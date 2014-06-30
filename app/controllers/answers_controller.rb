require "answer_handler"

class AnswersController < ApplicationController
  def create
    session[:ip] = request.env["REMOTE_HOST"]
    if answer_parameters[:user_challenge_id]
      user_challenge = UserChallenge
                       .find(answer_parameters[:user_challenge_id])
    end

    @answer = Answer.new(
                user_challenge: user_challenge,
                value: parse_value(answer_parameters[:value]),
                problem_id: answer_parameters[:problem_id],
                ip: session[:ip],
                level: level)

    @answer.user = current_user unless current_user.guest?

    handler = AnswerHandlerFactory.new(session,
                                       @answer.correct?,
                                       current_user,
                                       @answer.problem.skill,
                                       user_challenge)
                                  .build

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

  def level
    if !current_user.guest?
      user_skills = UserSkill.where(
        user: current_user,
        skill: Problem.find(answer_parameters[:problem_id]))
      user_skills.first_or_create.level
    end
  end

  def parse_value(value)
    value.gsub(",", ".")
  end
end
