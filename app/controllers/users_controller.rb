class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.where(user_group: current_user.user_group)
  end

  def show
    @user = User.find(current_user)
  end
end
