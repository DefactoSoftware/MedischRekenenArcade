class ProblemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @problem = Problem.maxisporin
  end
end
