# == Schema Information
#
# Table name: points
#
#  id         :integer          not null, primary key
#  amount     :integer
#  user_id    :integer
#  decrease   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Point < ActiveRecord::Base
  include RedisLeaderboard

  belongs_to :user

  after_create :update_leaderboard

  def self.increase(value=1, user)
    create(amount:value, user: user)
  end

  def self.decrease(value=1, user)
    create(amount:value*-1, user: user)
  end

  def update_leaderboard
    highscore_lb = RedisLeaderboard.get
    new_score = highscore_lb.score_for(user_id) ? highscore_lb.score_for(user_id) + amount : amount
    highscore_lb.rank_member(user_id, new_score)
  end
end
