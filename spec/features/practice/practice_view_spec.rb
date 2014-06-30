require "spec_helper"

describe "Practice", type: :feature do
  let(:user) { create(:user) }

  context "Guest user" do
    it "can answer a practice question" do
      visit "/practice"

      find("#answer_value").set("2")
      find("#submit_answer").click

      expect(page).to have_selector("#theory")
      expect(page).to have_selector("#answer_value")
      expect(page).to have_selector("#total_points")
    end
  end

  context "Logged in user" do
    it "can answer a practice question" do
      user.confirm!
      sign_in_user(user.email, "welkom1234")

      visit "/practice"

      find("#answer_value").set("2")
      find("#submit_answer").click

      expect(page).to have_selector("#theory")
      expect(page).to have_selector("#answer_value")
      expect(page).to have_selector("#total_points")
    end
  end
end
