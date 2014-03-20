require "spec_helper"

describe "Practice", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

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
      sign_in(user.email)

      visit "/practice"

      find("#answer_value").set("2")
      find("#submit_answer").click

      expect(page).to have_selector("#theory")
      expect(page).to have_selector("#answer_value")
      expect(page).to have_selector("#total_points")
    end
  end

  def sign_in(email)
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "user_email", with: email
      fill_in "user_password", with: "welkom1234"
      click_button("Sign in")
    end
  end
end
