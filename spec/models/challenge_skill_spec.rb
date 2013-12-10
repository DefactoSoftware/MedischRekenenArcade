# == Schema Information
#
# Table name: challenge_skills
#
#  id           :integer          not null, primary key
#  skill_id     :integer
#  challenge_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe ChallengeSkill do
  describe "Associations" do
    it { should belong_to(:challenge) }
    it { should belong_to(:skill) }
  end
end
