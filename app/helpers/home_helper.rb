module HomeHelper
  def personalized_welcome(user)
    if user
      "#{greeting_for_time(Time.now)} #{user.name}! "
    else
      "#{greeting_for_time(Time.now)}!"
    end
  end

  def greeting_for_time(time)
    morning_start = Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 6)
    afternoon_start = Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 12)
    evening_start = Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 18)
    if time >= morning_start && time < afternoon_start
      "Good morning"
    elsif time >= afternoon_start && time < evening_start
      "Good afternoon"
    elsif time >= evening_start
      "Good evening"
    else
      "Good night"
    end
  end
end
