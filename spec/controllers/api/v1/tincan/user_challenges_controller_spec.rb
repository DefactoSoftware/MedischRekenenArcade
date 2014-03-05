require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "UserChallenge" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user_id) { user2.id }

  let(:challenge) { FactoryGirl.create(:challenge) }
  let(:user_challenge) { FactoryGirl.create(:user_challenge, user: user, challenge: challenge) }

  let(:token) { double(accessible?: true, resource_owner_id: user.id) }


  before :each do
    Api::V1::Tincan::UserChallengesController.any_instance.stub(:doorkeeper_token) { token }
    Api::V1::BaseController.any_instance.stub(:current_user) { user }
  end

  get "/api/v1/tincan/user_challenges" do
    example_request "Return a list of user 1's userchallenges" do
      user_challenge.reload
      expect(status).to eq(200)
    end
  end

  get "/api/v1/tincan/user_challenges?user_id=:user_id" do
    example_request "Return a list of user 2's userchallenges" do
      expect(status).to eq(200)
    end
  end
end
