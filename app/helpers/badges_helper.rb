module BadgesHelper
  def badge_inactive(user, badge)
    if !user.badges.include?(badge)
      "inactive"
    end
  end
end
