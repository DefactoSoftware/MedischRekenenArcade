class Guest
  def id
    nil
  end

  def name
    nil
  end

  def username
    ""
  end

  def level
    nil
  end

  def answers
    Answer.none
  end

  def user_challenges
    UserChallenge.none
  end

  def badges
    Merit::BadgesSash.none
  end

  def user_group
    UserGroup.none
  end

  def activities
    Activity.none
  end

  def recent_activities
    Activity.none
  end

  def friends_with?
    false
  end

  def profilepicture_url
    "no_profile.jpg"
  end
end
