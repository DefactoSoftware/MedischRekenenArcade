module HomeHelper
  include Markdown

  MORNING_START = 5
  AFTERNOON_START = 11
  EVENING_START = 17

  def personalized_welcome(user)
    if user
      "#{greeting_for_time(Time.now)}! "
    else
      "#{greeting_for_time(Time.now)}!"
    end
  end

  def personalized_text(user)
    if user
      Markdown.get.render(t("home.logged_in_text", points: user.points)).html_safe
    else
      Markdown.get.render(t("home.standard_text")).html_safe
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
