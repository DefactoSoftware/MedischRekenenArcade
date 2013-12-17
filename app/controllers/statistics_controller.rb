class StatisticsController < ApplicationController
  before_action :authenticate_user!
  def index
    @challenges = current_user.challenges
  end
end
