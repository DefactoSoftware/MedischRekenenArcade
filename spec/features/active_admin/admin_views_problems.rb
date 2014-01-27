require "spec_helper"

feature "admin views a problem" do
  scenario "views the problem" do
    user = FactoryGirl.create(:user)
    problem = FactoryGirl.create(:problem)
    answer = FactoryGirl.create(:answer, problem: problem, user: user)

    sign_in_admin_user
    visit admin_problem_path(problem)

    expect(page).to have_content("ID")
    expect(page).to have_content("Theory")
    expect(page).to have_content("Difficulty")
    expect(page).to have_content("Created At")
    expect(page).to have_content("Updated At")
    expect(page).to have_content("Result")
    expect(page).to have_content("Unit")
    expect(page).to have_content("Answers")
  end
end
