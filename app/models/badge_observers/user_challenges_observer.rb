class UserChallengesObserver < BadgesObserver
  observe UserChallenge

  def after_update(user_challenge)
    init(user_challenge)
    check_winner_badge
    check_perfectionist_badge(user_challenge)
    check_speed_racer_badge(user_challenge) if user_challenge.complete?
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

  def check_speed_racer_badge(user_challenge)
    total_time = milliseconds_between_answers(user_challenge.answers.last,
                                              user_challenge.answers.first)
    timelimit = user_challenge.challenge.timelimit
    if timelimit && total_time / timelimit <= 0.25
      add_badge(BADGES[:speed_racer])
    end
  end

  def milliseconds_between_answers(answer_a, answer_b)
    (answer_a.created_at - answer_b.created_at) * 1000
  end
end
