class AbstractChallengesController < ApplicationController
  before_action :authenticate_user!
  def show
    set_challenge_variables

    if !session[:challenge]
      start_challenge_session
    end

    prepare_challenge_step
  end

  protected

  def calculate_time_left
    timelimit = Challenge.find(session[:challenge]).timelimit
    time_done = (Time.now.to_f - session[:start].to_f) * 1000
    time = timelimit - time_done
    seconds = time / 1000
    if seconds < 0
      redirect_to challenges_path, notice: t("challenge.time_is_up")
    end
    @minutes = (seconds / 60).floor
    seconds_left = (seconds / 60) - (seconds / 60).floor
    @seconds = ((seconds_left * 60).floor)
  end

  def set_challenge_variables
    @last_answer = Answer.where(user: current_user).last
  end

  def start_challenge_session
    session[:challenge] = @challenge.id
    session[:start] = Time.now
    create_user_challenge
    flash[:notice] = t("challenge.start")
    @info = I18n.t("challenges.info.#{@challenge.class.name}")
    @last_answer = Answer.new(feedback: I18n.t("challenge.start"))
  end

  def prepare_challenge_step
    find_user_challenge
    calculate_progress
    calculate_time_left if @challenge.timelimit
    @problem = @challenge.create_problem(current_user)
  end
end
