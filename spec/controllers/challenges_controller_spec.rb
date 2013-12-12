require 'spec_helper'

describe ChallengesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:challenge) { FactoryGirl.create(:challenge) }
  describe "GET index" do
    before :each do
      sign_in user.reload
    end
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
    before :each do
      sign_in user.reload
    end

    it "should render template" do
      get :show
    end
  end
end
