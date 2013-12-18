class StatisticsController < ApplicationController
  before_action :authenticate_user!
  def index
    @challenges = current_user.challenges
    @badges = current_user.badges
  end
end
