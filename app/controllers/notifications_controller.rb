class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notification = current_user.notifications.where(notified: false).last ||
                    nil
    if @notification
      @notification.update_attributes(notified: true)
      render layout: false
    else
      render nothing: true
    end
  end
end
