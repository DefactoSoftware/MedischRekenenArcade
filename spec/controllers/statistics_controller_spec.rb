require 'spec_helper'

describe StatisticsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:challenge) { FactoryGirl.create(:challenge) }
  let(:user_challenge) { FactoryGirl.create(:user_challenge, user: user, challenge: challenge) }

  before :each do
    sign_in user
    get :index, user_id: user.reload.id
  end

  describe "GET" do
    it "should render the template" do
      expect(response.status).to be(200)
    end
    it "Should assign @challenges" do
      expect(assigns(:challenges)).to eq(user.reload.challenges)
    end

    it "Should assign @badges" do
      expect(assigns(:badges)).to eq(user.reload.badges)
    end
  end
end
