require 'spec_helper'

describe ChallengesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:challenge) { FactoryGirl.create(:basic_challenge) }
  let(:skill) { FactoryGirl.create(:skill) }
  let(:challenge_skill) { FactoryGirl.create(:challenge_skill, skill:skill, challenge:challenge)}

  before :each do
    challenge.reload
    skill.reload
    challenge_skill.reload
    sign_in user.reload
  end

  describe "GET index" do
    it "should render template" do
      get :index
      expect(response.status).to eq(200)
    end

    it "should assign @challenges" do
      get :index
      expect(assigns(:challenges)).to eq(Challenge.all)
    end
  end

  describe "GET show" do
    it "should render template" do
      get :show, "/challenges", { id: challenge.name }
      expect(response.status).to eq(200)
    end
  end
end
