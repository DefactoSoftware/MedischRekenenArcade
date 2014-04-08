class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :update_sanitized_params, if: :devise_controller?
  before_filter :check_challenge
  protect_from_forgery with: :exception
  before_action :set_locale

  def all_activities
    users = User.where(user_group: current_user.user_group)
    Activity.where(user_id: users.map(&:id))
            .order("created_at DESC").limit(10)
  end

  def all_notifications
    current_user.notifications
  end

  helper_method :all_activities
  helper_method :all_notifications

  protected

  def set_locale
    I18n.locale = extract_locale_from_tld || I18n.default_locale
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :username, :name, :password,
               :password_confirmation, :profilepicture_url,
               :user_group_id)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password, :remember_me)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :username, :name, :password,
               :password_confirmation, :current_password,
               :profilepicture_url, :user_group_id)
    end
  end

  def check_challenge
    if params[:controller] != "challenges" &&
       params[:controller] != "answers" &&
       params[:controller] != "notifications"
      reset_challenge
    end
  end

  def reset_challenge
    session.delete(:damage)
    session.delete(:start)
    session.delete(:challenge)
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split(".").last
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end

  def devise_current_user
    @devise_current_user ||= warden.authenticate(scope: :user)
  end

  def current_user
    devise_current_user || Guest.new
  end

  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end

  helper_method :current_user
end
