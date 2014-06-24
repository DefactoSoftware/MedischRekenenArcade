require "spec_helper"

describe "the user process", type: :feature do
  it "signs me in and out" do
    user = create(:user)
    user.confirm!
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "welkom1234"
    end
    click_button "sign_in"
    expect(page).to have_selector("a#menu_logout")
    expect(page).to have_content user.username
    click_link "menu_logout"
    expect(page).to have_selector("a#menu_login")
  end
end
