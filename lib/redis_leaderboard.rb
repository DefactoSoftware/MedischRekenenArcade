module RedisLeaderboard
  def self.env_db
    Rails.env.test? ? "test_highscores" : "highscores"
  end
  def self.get
    Leaderboard.new(env_db, {redis_connection: $redis})
  end
end
