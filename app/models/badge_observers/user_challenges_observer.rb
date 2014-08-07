class UserChallengesObserver < BadgesObserver
  observe UserChallenge

  def after_update(user_challenge)
    init(user_challenge)
    check_winner_badge
    check_perfectionist_badge(user_challenge)
  end

  private

  def init(user_challenge)
    @user = user_challenge.user
    @badges = @user.badges
  end

  def check_winner_badge
    add_badge(BADGES[:winner]) if @user.challenges_completed_successfully == 1
  end

  def check_perfectionist_badge(user_challenge)
    if user_challenge.amount_fail == 0 && user_challenge.success?
      add_badge(BADGES[:perfectionist])
    end
  end
end
