module HomeHelper
  MORNING_START = 5
  AFTERNOON_START = 11
  EVENING_START = 17

  def personalized_welcome(user)
    if user
      "#{greeting_for_time(Time.now)} #{user.name}! "
    else
      "#{greeting_for_time(Time.now)}!"
    end
  end

  def personalized_text(user)
    if user
      t("home.standard_text")
    else
      t("home.standard_text")
    end
  end

  def greeting_for_time(time)
    hour = time.hour
    if hour.between?(MORNING_START, AFTERNOON_START)
      t("greetings.morning")
    elsif hour.between?(AFTERNOON_START, EVENING_START)
      t("greetings.afternoon")
    elsif hour >= EVENING_START
      t("greetings.evening")
    else
      t("greetings.night")
    end
  end
end
