module RedisLeaderboard
  def self.env_db
    Rails.env.test? ? "test_highscores" : "highscores"
  end
end
