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

class ChallengeSkill < ActiveRecord::Base
  belongs_to :skill
  belongs_to :challenge
end
