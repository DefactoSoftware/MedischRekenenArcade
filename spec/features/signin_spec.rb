require "spec_helper"

describe "the user process", type: :feature do
  it "signs me in and out" do
    user = FactoryGirl.create(:user)
    visit "/users/sign_in"
    expect(page).to have_content "Sign in"
    within("#new_user") do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "welkom1234"
    end
    click_button "sign_in"
    expect(page).to have_content "Log out"
    expect(page).to have_content user.username
    click_link "Log out"
    expect(page).to have_content "Sign in"
  end
end
