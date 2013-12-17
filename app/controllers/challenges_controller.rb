class ChallengesController < ApplicationController
  before_action :authenticate_user!
  def show
    @challenge = Challenge.where(name: params[:id]).first
    if !session[:challenge]
      session[:challenge] = @challenge.id
      session[:start] = Time.now
      UserChallenge.create(challenge: @challenge, user:current_user)
      flash[:notice] = t("challenge.start")
      user_challenge = UserChallenge.create(challenge: @challenge, user:current_user)
      track_activity user_challenge
    end
    calculate_time_left if @challenge.timelimit
    @problem = Problem.generate_random_with_skills(1, @challenge.skills)
  end

  def index
    reset_challenge
    @challenges = Challenge.all
  end

  private
  def calculate_time_left
    time = Challenge.find(session[:challenge]).timelimit - ((Time.now.to_f - session[:start].to_f) *1000)
    seconds = time / 1000
    if seconds < 0
      redirect_to challenges_path, notice: t("challenge.time_is_up")
    end
    @minutes = (seconds / 60).floor
    @seconds = (((seconds / 60) - (seconds/60).floor) * 60).floor
  end
end
