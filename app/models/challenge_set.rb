# == Schema Information
#
# Table name: challenge_sets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  locked     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class ChallengeSet < ActiveRecord::Base
  has_many :challenges

  def user_has_completed?(user)
    completed = false
    challenges.each do |challenge|
      completed = UserChallenge.where(challenge: challenge, user: user)
    end
    completed
  end
end
