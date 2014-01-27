require "spec_helper"

feature "admin views a problem" do
  scenario "views the problem" do
    user = FactoryGirl.create(:user)
    problem = FactoryGirl.create(:problem)
    answer = FactoryGirl.create(:answer, problem: problem, user: user)

    sign_in_admin_user
    visit admin_user_path(user)

    expect(page).to have_content("ID")
    expect(page).to have_content("Email")
    expect(page).to have_content("Last Sign In At")
    expect(page).to have_content("Current Sign In At")
    expect(page).to have_content("Last Sign In Ip")
    expect(page).to have_content("Current Sign In Ip")
    expect(page).to have_content("Username")
    expect(page).to have_content("Name")
    expect(page).to have_content("User Group")
  end
end
