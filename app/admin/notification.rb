ActiveAdmin.register Notification do

  controller do
    def create
      User.all.each do |u|
        puts params
        notification = Notification.create(notification_params)
        notification.update_attributes(user:u, trackable_type: "basic")
      end
      redirect_to request.referer, notice: "Created notification for all users"
    end

    private
    def notification_params
      params.require(:notification).permit(:text, :image, :title)
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :text
      f.input :image
    end
    f.actions
  end
end
