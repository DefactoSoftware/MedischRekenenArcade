require 'spec_helper'

describe LeaderboardsController do
  let(:user_group) { FactoryGirl.create(:user_group, name: "NHL") }
  let(:user1) { FactoryGirl.create(:user, user_group: user_group) }
  let(:user2) { FactoryGirl.create(:user, user_group: user_group) }
  let(:user3) { FactoryGirl.create(:user) }


  describe "GET index" do
    before :each do
      Leaderboard.new('test_highscores').delete_leaderboard
    end

    it "Assigns 3 variables with scores" do
      sign_in user1.reload
      Point.increase(3,user1)
      Point.increase(2,user2)
      Point.increase(5,user3)
      get :index
      expect(assigns(:top_scores)).to be_an_instance_of(Array)
      expect(assigns(:top_scores).length).to be(3)
      expect(assigns(:top_scores)[0][:score]).to eq(5.0)
      expect(assigns(:top_scores)[1][:score]).to eq(3.0)
      expect(assigns(:top_scores)[2][:score]).to eq(2.0)

      expect(assigns(:around_me_scores)).to be_an_instance_of(Array)
      expect(assigns(:around_me_scores).length).to eq(3)
      expect(assigns(:around_me_scores)[0][:score]).to eq(5.0)
      expect(assigns(:around_me_scores)[1][:score]).to eq(3.0)
      expect(assigns(:around_me_scores)[2][:score]).to eq(2.0)

      expect(assigns(:user_group_scores)).to be_an_instance_of(Array)
      expect(assigns(:user_group_scores).length).to eq(2)
      expect(assigns(:user_group_scores)[0][:score]).to eq(3.0)
      expect(assigns(:user_group_scores)[1][:score]).to eq(2.0)
    end

    it "returns a 200 code when logged in" do
      sign_in user1.reload
      get :index
      expect(response.status).to be(200)
    end

    it "redirects to sign_in when not logged in" do
      get :index
      expect(response.status).to be(302)
      expect(response).to redirect_to("/users/sign_in")
    end
  end
end
