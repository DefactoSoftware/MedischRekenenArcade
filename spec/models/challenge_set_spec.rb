# == Schema Information
#
# Table name: challenge_sets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  locked     :boolean
#  created_at :datetime
#  updated_at :datetime
#  badge      :integer
#

require "spec_helper"

describe ChallengeSet, type: :model do
  describe "Associations" do
    it { is_expected.to have_many(:challenges) }
  end

  let(:challenge_set) { create(:challenge_set_with_challenges) }
  let(:user) { create(:user) }

  describe "completion for user" do
    it "true if user completed all challenges of a challengeset" do
      challenge_set.challenges.each do |challenge|
        create(:user_challenge, user: user, challenge: challenge)
      end

      expect(challenge_set.check_completion_for(user)).to eq(true)
    end

    it "false if user did not complete all challenges" do
      expect(challenge_set.check_completion_for(user)).to eq(false)
    end

    it "false if user completed 1 challenge" do
      create(:user_challenge, user: user,
                              challenge: challenge_set.challenges.first)
      expect(challenge_set.check_completion_for(user)).to eq(false)
    end
  end
end
