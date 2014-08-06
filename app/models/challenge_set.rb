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

class ChallengeSet < ActiveRecord::Base
  has_many :challenges

  def check_completion_for(user)
    complete = false
    challenges.each do |challenge|
      complete = !UserChallenge.where(challenge: challenge, user: user).empty?
    end
    complete
  end

  def assign_badge_for(user)
    user.add_badge(badge)
  end
end
