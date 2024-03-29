require "spec_helper"

describe ChallengesController, type: :controller do
  let(:user) { create(:user) }
  let(:challenge_set) { create(:challenge_set) }
  let(:challenge) { create(:challenge, name: "Addition") }
  let(:skill) { Skill.create(name: "Addition") }

  before :each do
    challenge.reload
    skill.reload
    sign_in user.reload
  end

  describe "GET index" do
    it "should render template" do
      get :index
      expect(response.status).to eq(200)
    end

    it "should assign @challengesets" do
      get :index
      expect(assigns(:challengesets))
      .to eq(ChallengeSet.where(locked: false)
      .order("NAME ASC"))
    end
  end

  describe "GET show" do
    it "should render template" do
      get :show, "/challenges", id: challenge.name
      expect(response.status).to eq(200)
    end
  end
end
