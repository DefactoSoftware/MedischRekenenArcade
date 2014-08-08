class BadgesSashObserver < ActiveRecord::Observer
  observe Merit::BadgesSash

  def after_create(badge_sash)
    user = User.find_by_sash_id(badge_sash.sash_id)

    Activity.create(action: "collect", trackable: badge_sash, user: user)
    Notification.create(trackable: badge_sash,
                        user: user,
                        image: badge_sash.badge.image)
  end
end
