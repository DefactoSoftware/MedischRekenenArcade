class BadgesSashObserver < ActiveRecord::Observer
  observe Merit::BadgesSash

  # A badge_sash has badge_id and sash_id foreign keys
  def after_create(badge_sash)
    # In this case the User model has a `has_merit` call,
    # and so has a sash_id foreign key
    user = User.find_by_sash_id(badge_sash.sash_id)

    #CREATE ACTIVITY HERE

  end
end