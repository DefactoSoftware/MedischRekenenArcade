class ProblemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @problem = SolutionMaxisporin.generate
  end
end
