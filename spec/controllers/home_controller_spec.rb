require "spec_helper"

describe HomeController, type: :controller do
  describe "Index" do
    it "should return status 302" do
      get :index
      expect(response.status).to eq(302)
    end
  end

  describe "Last challenge" do
    let(:user) { create(:user) }
    let(:challenge) { create(:challenge) }
    let(:user_challenge) do
      create(:user_challenge, challenge: challenge, user: user)
    end

    describe "when logged in" do
      it "has a last challenge" do
        user_challenge.reload
        sign_in user
        get :index
        expect(assigns(:last_challenge)).to be_an_instance_of(Challenge)
      end
    end

    describe "when not logged in" do
      it "doesn't have a last challenge" do
        get :index
        expect(assigns(:last_challenge)).to be(nil)
      end
    end
  end
end
