require "spec_helper"

describe "Badges", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    user.confirm!
    sign_in_user(user.email, "welkom1234")
  end

  context "index" do
    it "contains all badges" do
      visit "/badges"
      Merit::Badge.all.each do |badge|
        expect(page).to have_content(I18n.t("badges.#{badge.name}.name"))
        expect(page).to have_content(I18n.t("badges.#{badge.description}"))
      end

    end

    it "shows users badges without inactive class" do
      user.add_badge(1)
      visit "/badges"
      expect(page).to have_no_xpath("a[@class='inactive' and @id='#{Merit::Badge.find(1).name}']")
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
