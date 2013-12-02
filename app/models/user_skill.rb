# == Schema Information
#
# Table name: user_skills
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  skill_id   :integer
#  level      :float
#  created_at :datetime
#  updated_at :datetime
#

class UserSkill < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
end
