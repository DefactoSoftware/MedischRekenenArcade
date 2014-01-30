class ProblemsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:problem] && params[:problem] != ""
      @problem = ProblemFactory.new(params[:problem], current_user).problem
    else
      @problem = Problem.generate_random(1)
    end
  end
end
