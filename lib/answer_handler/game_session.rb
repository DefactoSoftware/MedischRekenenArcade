class GameSession
  def initialize(session)
    @session = session
  end

  def ip
    @session[:ip]
  end

  def streak
    @session[:streak]
  end

  def damage
    @session[:damage]
  end

  def start_time
    @session[:start_time]
  end

  def challenge_id
    @session[:challenge_id]
  end

  def reset_challenge!
    @session.delete(:damage)
    @session.delete(:start)
    @session.delete(:challenge)
  end

  def reset_streak!
    @session[:streak] = 0
  end

  def decrease_damage!
    if @session[:damage] && @session[:damage] > 0
      @session[:damage] = @session[:damage].to_i - 1
    end
  end

  def increase_damage!
    @session[:damage] = @session[:damage].to_i + 1
  end

  def increase_streak!(value = 1)
    @session[:streak] =  @session[:streak].to_i + value
  end
end
