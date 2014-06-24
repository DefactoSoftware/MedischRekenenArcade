class ProblemsController < ApplicationController
  def index
    @last_answer = current_user.answers.last ||
                   Answer.where(ip: request.env["REMOTE_HOST"]).last
    @suggested_skill = SkillSuggester.new(current_user).skill
    @problem = ProblemFactory.new(params[:problem] ||
                                  "Addition", current_user).problem
  end
end
