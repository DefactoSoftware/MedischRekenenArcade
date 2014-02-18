class UserGroupsController < ApplicationController
  def create
    @user_group = UserGroup.new(user_group_parameters)

    if @user_group.save!
      redirect_to request.referer, notice: t("user_group.save.success")
    else
      redirect_to request.referer, error: t("user_group.save.error")
    end
  end

  private
  def user_group_parameters
    params.require(:user_group).permit(:name)
  end
end
