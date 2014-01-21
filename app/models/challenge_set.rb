# == Schema Information
#
# Table name: challenge_sets
#
#  id            :integer          not null, primary key
#  challenges_id :integer
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class ChallengeSet < ActiveRecord::Base
  has_many :challenges
end
