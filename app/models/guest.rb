class Guest
  def guest?
    true
  end

  def id
    nil
  end

  def name
    "guest"
  end

  def username
    "guest"
  end

  def user_challenges
    UserChallenge.none
  end

  def badges
    Merit::BadgesSash.none
  end

  def answers
    Answer.none
  end

  def user_skills
    UserSkill.none
  end

  def _sash
    Merit::Sash.none
  end

  def notifications
    Notification.none
  end
end
