# == Schema Information
#
# Table name: challenges
#
#  id                 :integer          not null, primary key
#  number_of_problems :integer
#  name               :string(255)
#  timelimit          :integer
#  bonus              :integer
#  icon               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Challenge < ActiveRecord::Base
  has_many :challenge_skills
  has_many :skills, through: :challenge_skills
  has_many :user_challenges
end
