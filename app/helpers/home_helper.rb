module HomeHelper
  include Markdown

  MORNING_START = 5
  AFTERNOON_START = 11
  EVENING_START = 17

  def personalized_welcome(user)
    if user.guest?
      "#{greeting_for_time(Time.now)}! "
    else
      "#{greeting_for_time(Time.now)}!"
    end
  end

  def personalized_text(user)
    if user.guest?
      Markdown.get.render(t("home.standard_text")).html_safe
    else
      Markdown.get.render(t("home.logged_in_text", points: user.points)).html_safe
    end
  end

  def call_to_action_buttons(user)
    content = ActiveSupport::SafeBuffer.new
    if user.guest?
      content.concat sign_up_button
      content.concat sign_in_button
      content.concat practice_button
    else
      content.concat challenges_button
      content.concat practice_button
    end
    content.html_safe
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

  private
  def sign_up_button
    link_to new_user_registration_path do
      content_tag(:button, t("menu.sign_up"), class: "btn btn-landing")
    end
  end

  def sign_in_button
    link_to new_user_session_path do
      content_tag(:button, t("menu.login"), class: "btn btn-landing")
    end
  end

  def challenges_button
    link_to challenges_path do
      content_tag(:button, t("menu.challenges"), class: "btn btn-landing")
    end
  end

  def practice_button
    link_to practice_path do
      content_tag(:button, t("menu.practice"), class: "btn btn-landing")
    end
  end
end
