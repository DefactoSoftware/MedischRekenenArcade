require "spec_helper"

describe StatisticsController, type: :controller do
  let(:user) { create(:user) }
  let(:challenge) { create(:challenge) }
  let(:user_challenge) do
    create(:user_challenge, user: user, challenge: challenge)
  end

  before :each do
    sign_in user
    get :index, user_id: user.id
  end

  describe "GET" do
    it "should render the template" do
      expect(response.status).to be(200)
    end
    it "Should assign @challenges" do
      expect(assigns(:challenge_sets))
    end

    it "Should assign @badges" do
      expect(assigns(:badges)).to eq(user.badges)
    end
  end
end
