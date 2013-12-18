require 'spec_helper'

describe LeaderboardsController do
  let(:user_group) { FactoryGirl.create(:user_group, name: "NHL") }
  let(:user1) { FactoryGirl.create(:user, user_group: user_group) }
  let(:user2) { FactoryGirl.create(:user, user_group: user_group) }
  let(:user3) { FactoryGirl.create(:user) }
  let(:random_score1) { rand(10..20) }
  let(:random_score2) { rand(21..50) }
  let(:random_score3) { rand(51..100) }


  describe "GET index" do
    it "Assigns 3 variables with scores" do
      Leaderboard.new('test_highscores').delete_leaderboard

      sign_in user1.reload

      user1.increase_points(random_score1)
      user2.increase_points(random_score2)
      user3.increase_points(random_score3)

      get :index

      expect(assigns(:top_scores)).to be_an_instance_of(Array)
      expect(assigns(:top_scores).length).to be(3)
      expect(assigns(:top_scores)[0][:score]).to eq(random_score3)
      expect(assigns(:top_scores)[1][:score]).to eq(random_score2)
      expect(assigns(:top_scores)[2][:score]).to eq(random_score1)

      expect(assigns(:around_me_scores)).to be_an_instance_of(Array)
      expect(assigns(:around_me_scores).length).to eq(3)
      expect(assigns(:around_me_scores)[0][:score]).to eq(random_score3)
      expect(assigns(:around_me_scores)[1][:score]).to eq(random_score2)
      expect(assigns(:around_me_scores)[2][:score]).to eq(random_score1)

      expect(assigns(:user_group_scores)).to be_an_instance_of(Array)
      expect(assigns(:user_group_scores).length).to eq(2)
      expect(assigns(:user_group_scores)[0][:score]).to eq(random_score2)
      expect(assigns(:user_group_scores)[1][:score]).to eq(random_score1)
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
