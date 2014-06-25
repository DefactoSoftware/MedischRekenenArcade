# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require "spec_helper"

describe Skill, type: :model do
  describe "#get_random" do
    it "returns a random skill" do
      create(:skill)
      create(:skill)
      expect(Skill.get_random).to be_a(Skill)
    end
  end
end
