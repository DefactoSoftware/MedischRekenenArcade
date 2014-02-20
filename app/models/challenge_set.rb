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

  def user_check_completed(user)
    if user.badges.include?(Merit::Badge.find(badge))
      completed = false
      challenges.each do |challenge|
        completed = UserChallenge.where(challenge: challenge, user: user)
      end
      if completed
        user.add_badge(badge)
      end
    end
  end
end
