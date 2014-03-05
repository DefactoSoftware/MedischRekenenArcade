class Guest
  def name
    nil
  end

  def username
    nil
  end

  def answers
    Answer.none
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
end
