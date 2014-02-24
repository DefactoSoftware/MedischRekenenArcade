require "spec_helper"

describe "Challenges", type: :feature do
  xit "opens a challenge" do
    user = FactoryGirl.create(:user)
    user.confirm!

    visit "/users/sign_in"
    within("#new_user") do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "welkom1234"
    end

    visit "/challenges/Addition"

    theory = find("#theory").text
    answer = eval(theory)

    fill_in "#answer_value", with: answer

    click "#submit_answer"

    expect(page).to have_selector('p#theory')
  end
end
