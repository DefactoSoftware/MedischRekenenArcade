module HomeHelper
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
    morning_start = Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 6)
    afternoon_start = Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 12)
    evening_start = Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 18)
    if time >= morning_start && time < afternoon_start
      t("greetings.morning")
    elsif time >= afternoon_start && time < evening_start
      t("greetings.afternoon")
    elsif time >= evening_start
      t("greetings.evening")
    else
      t("greetings.night")
    end
  end
end
