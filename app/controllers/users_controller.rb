class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    user_array = User.where(user_group: current_user.user_group)
    @users = user_array.sort_by { |user| user.points }.reverse
  end

  def show
    redirect_to user_statistics_path(User.find(params[:id]))
  end
end
