require 'spec_helper'

describe SkillSuggester do
  let(:user) { FactoryGirl.create(:user) }
  let(:skill1) { FactoryGirl.create(:skill) }
  let(:skill2) { FactoryGirl.create(:skill) }
  let(:user_skill1) { FactoryGirl.create(:user_skill, skill: skill1, user: user, level: 2) }
  let(:user_skill2) { FactoryGirl.create(:user_skill, skill: skill2, user: user, level: 10) }
  let(:skill_suggester) { SkillSuggester.new(user) }

  it "returns the lowest ranked skill for user" do
    user_skill1.reload
    user_skill2.reload
    expect(skill_suggester.skill).to eq(skill1)
  end
end
