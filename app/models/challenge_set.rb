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
end
