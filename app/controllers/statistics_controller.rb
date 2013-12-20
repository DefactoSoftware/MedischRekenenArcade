class StatisticsController < ApplicationController
  before_action :authenticate_user!
  def index
    @challenges = User.find(params[:user_id]).challenges
    @badges = User.find(params[:user_id]).badges
  end
end
