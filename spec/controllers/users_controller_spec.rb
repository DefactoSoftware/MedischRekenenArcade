require "spec_helper"

describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before :each do
    sign_in user
  end

  describe "#index" do
    it "should return status 200" do
      get :index
      expect(response.status).to eq(200)
      expect(assigns(@users))
    end
  end

  describe "#show" do
    it "should redirect to statistics" do
      get :show, id: user.id
      expect(response.status).to eq(302)
    end
  end
end
