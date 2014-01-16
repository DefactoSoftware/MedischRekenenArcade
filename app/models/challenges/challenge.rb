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
#  steps              :integer
#  type               :string(255)
#

class Challenge < ActiveRecord::Base
  has_many :challenge_skills
  has_many :skills, through: :challenge_skills
  has_many :user_challenges


  def total_correct_answers_for_user(user)
    userchallenges = self.user_challenges.where(user: user)
    userchallenges.reduce(0) { |total, userchallenge|  total += userchallenge.amount_good }
  end

  def total_incorrect_answers_for_user(user)
    userchallenges = self.user_challenges.where(user: user)
    userchallenges.reduce(0) { |total, userchallenge|  total += userchallenge.amount_fail }
  end

  def total_success_for_user(user)
    self.user_challenges.where(user: user, success: true).count
  end

  def total_failed_for_user(user)
    self.user_challenges.where(user: user, success: false || nil).count
  end
end
