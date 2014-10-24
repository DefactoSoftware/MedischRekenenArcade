require "spec_helper"

describe "Challenges", type: :feature do
  let(:challenge_set) do
    ChallengeSet.where(name: "Week_1", locked: false).first_or_create
  end
  let(:challenge) do
    Challenge.where(name: "Addition",
                    number_of_problems: 10,
                    steps: 1,
                    timelimit: 900000,
                    bonus: 20,
                    icon: "challenges/Menu_Optellen.png",
                    challenge_set: challenge_set)
             .first_or_create
  end
  let(:user) { create(:user) }

  before :each do
    sign_in_user(user.email, "welkom1234")
    challenge_set.reload
    challenge.reload
  end

  context "index" do
    it "contains created challenge" do
      visit "/challenges"
      expect(page).to have_link("", href: "/challenges/#{challenge.name}")
    end

    it "can open a single challenge" do
      visit "/challenges"
      find(:xpath, "//*[@id='challenges_block']/div[1]/div/a").click
    end
  end

  context "show" do
    it "shows a challenge" do
      visit "/challenges/#{challenge.name}"
      expect(page).to have_selector("#theory")
      expect(page).to have_selector("#answer_value")
      expect(page).to have_selector("#total_points")
    end

    it "allows the user to submit an answer" do
      visit "/challenges/#{challenge.name}"
      find("#answer_value").set("2")
      find("#submit_answer").click
      expect(page).to have_selector("#theory")
    end
  end
end
