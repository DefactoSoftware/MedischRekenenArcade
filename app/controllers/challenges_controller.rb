class ChallengesController < ApplicationController
  def show
    @challenge = Challenge.where(name: params[:id]).first
    if !session[:challenge]
      session[:challenge] = @challenge.id
      session[:start] = DateTime.now
      UserChallenge.create(challenge: @challenge, user:current_user)
      flash[:notice] = "Starting new challenge, good luck! If you make more than 6 mistakes the patient dies so be careful!"
    end
    @problem = Problem.generate_random_with_skills(3, @challenge.skills)
  end

  def index
    @challenges = Challenge.all
  end
end
