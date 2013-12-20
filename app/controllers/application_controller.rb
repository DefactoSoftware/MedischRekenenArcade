class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :update_sanitized_params, if: :devise_controller?
  before_filter :check_challenge
  protect_from_forgery with: :exception

  protected
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :username, :name, :password, :password_confirmation, :profile_picture_url, :user_group_id)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update)  {|u| u.permit(:email, :username, :name, :password, :password_confirmation, :current_password, :profile_picture_url, :user_group_id)}
  end

  def check_challenge
    if params[:controller] != "challenges" && params[:controller] != "answers"
      reset_challenge
    end
  end

  def reset_challenge
    session.delete(:damage)
    session.delete(:start)
    session.delete(:challenge)
  end

  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end
end
