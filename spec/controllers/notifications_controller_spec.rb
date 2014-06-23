require 'spec_helper'

describe NotificationsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in user
  end

  describe "Index" do
    it "should not render anything if there's no notification" do
      get :index
      expect(assigns(:notification)).to be(nil)
    end
    it "should render a notification" do
      Notification.create(user: user, image: "no_image.png", trackable_type: "basic", text: "test")
      get :index
      expect(response).to render_template("notifications/index")
      expect(assigns(:notification)).to be_a(Notification)
    end
  end
end
