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
  has_many :users
  has_many :skills
end
