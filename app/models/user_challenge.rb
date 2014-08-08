# == Schema Information
#
# Table name: user_challenges
#
#  id                        :integer          not null, primary key
#  user_id                   :integer
#  challenge_id              :integer
#  success                   :boolean
#  amount_fail               :integer          default(0)
#  amount_good               :integer          default(0)
#  created_at                :datetime
#  updated_at                :datetime
#  head_to_head_challenge_id :integer
#

class UserChallenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  belongs_to :head_to_head_challenge
  has_many :answers

  after_update :track_activity

  def amount_answered
    amount_fail + amount_good
  end

  def complete?
    amount_answered == challenge.number_of_problems
  end

  private

  def track_activity
    if self.success_changed?
      if success?
        user.activities.create! action: "complete", trackable: self
      else
        user.activities.create! action: "fail", trackable: self
      end
    end
  end
end
