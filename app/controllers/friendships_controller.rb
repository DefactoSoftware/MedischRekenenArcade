class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      redirect_to root_url, status: 201
    else
      redirect_to root_url, status: 422
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end

  def friendship_parameters
    params.require(:friendship).permit(:friend_id)
  end
end
