# == Schema Information
#
# Table name: user_challenges
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  challenge_id :integer
#  success      :boolean
#  amount_fail  :integer          default(0)
#  amount_good  :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

class UserChallenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  after_update :track_activity

  private
  def track_activity
    if self.success_changed?
      if success?
        user.activities.create! action: "complete", trackable: self
        add_badges
      else
        user.activities.create! action: "fail", trackable: self
      end
    end
  end

  def add_badges
    if user.challenges_completed_successfully == 1
      user.add_badge(3)
    end
    if user.challenges_completed_successfully == 10
      user.add_badge(4)
    end
  end
end
