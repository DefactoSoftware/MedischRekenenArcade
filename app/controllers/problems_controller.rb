class ProblemsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:problem] && params[:problem] != ""
      @problem = ProblemFactory.new(params[:problem]).problem
    else
      @problem = Problem.generate_random(1)
    end
  end
end
