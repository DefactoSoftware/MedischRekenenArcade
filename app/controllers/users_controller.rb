class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.where(user_group: current_user.user_group).sort_by { |user| user.points }.reverse
  end

  def show
    redirect_to user_statistics_path(User.find(params[:id]))
  end
end
