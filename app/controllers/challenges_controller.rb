class ChallengesController < ApplicationController
  before_action :authenticate_user!
  def show
    @last_answer = Answer.where(user: current_user).last
    @challenge = Challenge.where(name: params[:id]).first
    if !session[:challenge]
      session[:challenge] = @challenge.id
      session[:start] = Time.now
      flash[:notice] = t("challenge.start")
      user_challenge = UserChallenge.create(challenge: @challenge,
                                            user: current_user)
      track_activity(user_challenge, "start")
      @info = I18n.t("challenges.info.#{@challenge.class.name}")
      @last_answer = Answer.new(feedback: I18n.t("challenge.start"))
    end
    challenge = Challenge.find(session[:challenge])
    @user_challenge = UserChallenge.where(challenge: challenge,
                                          user: current_user).last
    @progress = (Float(@user_challenge.amount_good) /
                Float(@user_challenge.challenge.number_of_problems)) * 100
    calculate_time_left if @challenge.timelimit
    @problem = @challenge.create_problem(current_user)
  end

  def index
    reset_challenge
    @challengesets = ChallengeSet.where(locked: false).order("NAME ASC")
  end

  private

  def calculate_time_left
    timelimit = Challenge.find(session[:challenge]).timelimit
    time_since_start = (Time.now.to_f - session[:start].to_f) * 1000
    time = timelimit - time_since_start
    seconds = time / 1000
    if seconds < 0
      redirect_to challenges_path, notice: t("challenge.time_is_up")
    end
    @minutes = (seconds / 60).floor
    @seconds = (((seconds / 60) - (seconds / 60).floor) * 60).floor
  end
end
