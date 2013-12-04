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

  def update_leaderboard
    highscore_lb = Leaderboard.new(RedisLeaderboard.env_db)
    highscore_lb.rank_member(user_id, user.get_points)
  end
end
