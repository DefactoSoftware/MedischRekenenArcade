# == Schema Information
#
# Table name: user_challenges
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  challenge_id :integer
#  success      :boolean
#  amount_fail  :integer
#  amount_good  :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class UserChallenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
end
