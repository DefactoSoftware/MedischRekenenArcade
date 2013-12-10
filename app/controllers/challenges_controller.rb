class ChallengesController < ApplicationController
  def show
    @challenge = Challenge.where(name: params[:id]).first
    @problem = Problem.generate_random_with_skills(1, @challenge.skills)
  end

  def index
    @challenges = Challenge.all
  end
end
