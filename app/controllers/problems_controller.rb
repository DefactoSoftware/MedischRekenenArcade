class ProblemsController < ApplicationController
  def index
    @last_answer = current_user.answers.last || Answer.last
    @suggested_skill = SkillSuggester.new(current_user).skill
    @problem = ProblemFactory.new(params[:problem] || "Mixed", current_user).problem
  end
end
