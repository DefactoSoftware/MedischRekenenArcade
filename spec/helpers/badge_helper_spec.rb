require "spec_helper"
describe BadgesHelper, type: :helper do
  include BadgesHelper

  let(:user) { create(:user) }

  describe "When user doesn't have badge" do
    it "returns inactive" do
      expect(badge_inactive(user, Merit::Badge.find(1)))
      .to eq("inactive")
    end
  end

  describe "When user has badge" do
    it "doesn't return inactive" do
      user.add_badge(1)
      expect(badge_inactive(user, Merit::Badge.find(1)))
      .to eq(nil)
    end
  end
end
