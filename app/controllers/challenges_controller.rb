class ChallengesController < ApplicationController
  def show
    @challenge = Challenge.where(name: params[:id]).first
    if !session[:challenge]
      session[:challenge] = @challenge.id
      session[:start] = Time.now
      UserChallenge.create(challenge: @challenge, user:current_user)
      flash[:notice] = "Starting new challenge, good luck! If you make more than 6 mistakes the patient dies so be careful!"
    end
    calculate_time_left
    @problem = Problem.generate_random_with_skills(3, @challenge.skills)
  end

  def index
    @challenges = Challenge.all
  end

  private
  def calculate_time_left
    time = Challenge.find(session[:challenge]).timelimit - ((Time.now.to_f - session[:start].to_f) *1000)
    seconds = time / 1000
    if seconds < 0
      redirect_to challenges_path, notice: "Time is up"
      reset_challenge
    end
    @minutes = (seconds / 60).floor
    @seconds = (((seconds / 60) - (seconds/60).floor) * 60).floor
  end

  def reset_challenge
    session.delete(:damage)
    session.delete(:start)
    session.delete(:challenge)
  end
end
