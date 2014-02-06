class ProblemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @last_answer = Answer.where(user:current_user).last
    @problem = ProblemFactory.new(params[:problem] || "Mixed", current_user).problem
  end
end
