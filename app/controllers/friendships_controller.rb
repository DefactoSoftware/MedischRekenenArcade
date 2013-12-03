class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      redirect_to root_url, status: :ok
    else
      redirect_to root_url, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    if @friendship.destroy
      redirect_to request.referer, status: :ok
    else
      redirect_to request.referer, status: :unprocessable_entity
    end
  end

  def friendship_parameters
    params.require(:friendship).permit(:friend_id)
  end
end
