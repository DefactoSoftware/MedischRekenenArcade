class UsersObserver < BadgesObserver
  observe User

  def after_update(user)
    init(user)
    check_sign_up_badge
    check_vanity_badge
  end

  private

  def init(user)
    @user = user
    @badges = @user.badges
  end

  def check_sign_up_badge
    add_badge(BADGES[:particioner]) if @user.confirmed_at
  end

  def check_vanity_badge
    add_badge(BADGES[:narcissist]) if @user.confirmed_at &&
                                      @user.profilepicture_url !=
                                        "assets/no_profile.jpg"
  end
end
