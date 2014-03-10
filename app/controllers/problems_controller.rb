class ProblemsController < ApplicationController
  def index
    @last_answer = Answer.where(user:current_user).last
    @suggested_skill = SkillSuggester.new(current_user).skill
    @problem = ProblemFactory.new(params[:problem] || @suggested_skill.name, current_user).problem
  end
end
