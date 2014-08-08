class AnswersObserver < BadgesObserver
  observe Answer

  def after_create(answer)
    init(answer)
    check_questions_answered_badges
    check_time_of_day_badges
    check_cold_feet_badges
    check_practice_badge(answer)
  end

  private

  def init(answer)
    unless answer.user.guest?
      @user = answer.user
      @badges = @user.badges
      @answer_count = @user.answers.count
      @created_at = answer.created_at
      @challenge_count = UserChallenge.where(user: @user).count
    end
  end

  def check_practice_badge(answer)
    if answer.user_challenge == nil
      add_badge(BADGES[:practicer])
    end
  end

  def check_questions_answered_badges
    case @answer_count
    when 10
      add_badge(BADGES[:questions_answered_a])
    when 100
      add_badge(BADGES[:questions_answered_b])
    when 1000
      add_badge(BADGES[:questions_answered_c])
    end
  end

  def check_time_of_day_badges
    if @created_at.hour.between?(MORNING_START, AFTERNOON_START)
      add_badge(BADGES[:rise_and_shine])
    elsif @created_at.hour.between?(EVENING_START, NIGHT_START)
      add_badge(BADGES[:night_crawler])
    elsif @created_at.hour.between?(NIGHT_START, MORNING_START)
      add_badge(BADGES[:night_owl])
    end
  end

  def check_cold_feet_badges
    if @challenge_count == 0
      case @answer_count
      when 10
        add_badge(BADGES[:cold_feet_a])
      when 50
        add_badge(BADGES[:cold_feet_b])
      when 100
        add_badge(BADGES[:cold_feet_c])
      end
    end
  end
end
