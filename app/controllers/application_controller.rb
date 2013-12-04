class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :update_sanitized_params, if: :devise_controller?
  protect_from_forgery with: :exception

  protected
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :username, :name, :password, :password_confirmation, :profile_picture_url)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update)  {|u| u.permit(:email, :username, :name, :password, :password_confirmation, :current_password, :profile_picture_url)}
  end
end
