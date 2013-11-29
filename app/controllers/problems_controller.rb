class ProblemsController < ApplicationController
  before_action :authenticate_user!
  def show
    @problem = Problem.Maxisporin
  end
end
