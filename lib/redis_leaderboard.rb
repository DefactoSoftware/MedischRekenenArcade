module RedisLeaderboard
  def self.env_db
    if Rails.env.test?
      'test_highscores'
    else
      'highscores'
    end
  end
end
