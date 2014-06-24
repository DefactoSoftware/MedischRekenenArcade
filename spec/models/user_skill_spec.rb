# == Schema Information
#
# Table name: user_skills
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  skill_id   :integer
#  level      :float            default(0.0)
#  created_at :datetime
#  updated_at :datetime
#

require "spec_helper"

describe UserSkill, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:skill) }
  end
end
