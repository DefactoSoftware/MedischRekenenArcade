require "spec_helper"

describe SkillSuggester do
  let(:user) { create(:user) }
  let(:skill1) { create(:skill) }
  let(:skill2) { create(:skill) }
  let(:user_skill1) do
    create(:user_skill, skill: skill1, user: user, level: 2)
  end
  let(:user_skill2) do
    create(:user_skill, skill: skill2, user: user, level: 10)
  end
  let(:skill_suggester) { SkillSuggester.new(user) }

  it "returns the lowest ranked skill for user" do
    user_skill1.reload
    user_skill2.reload
    expect(skill_suggester.skill).to eq(skill1)
  end
end
