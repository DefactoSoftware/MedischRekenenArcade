class AnswerHandler
  attr_reader :session, :user, :answer_is_correct, :skill

  STANDARD_POINT_AMOUNT = 1
  STANDARD_STREAK_AMOUNT = 1

  def initialize(session, current_user, skill)
    @user = current_user
    @session = GameSession.new(session)
    @skill = skill
  end

  def handle!
    check_badges
  end

  def method_missing(method, *args, &block)
    session.send(method, *args, &block)
  end

  def increase_skill!(value=1)
    user_skill = UserSkill.where(user: @user, skill: @skill).first_or_create
    user_skill.update_attributes(level: user_skill.level+value)
  end

  def decrease_skill!(value=1)
    user_skill = UserSkill.where(user: @user, skill: @skill).first_or_create
    user_skill.update_attributes(level: user_skill.level-value) if user_skill.level > 0
  end


  def increase_points!(value=1)
    user.increase_points(value)
  end

  def decrease_points!(value=1)
    user.decrease_points(value)
  end

  def check_badges
    if !@user.badges.include?(Merit::Badge.find(5)) && @session.streak == 10
      @user.add_badge(5)
    end
    if !@user.badges.include?(Merit::Badge.find(6)) && @session.streak == 50
      @user.add_badge(6)
    end
    if !@user.badges.include?(Merit::Badge.find(7)) && @session.streak == 100
      @user.add_badge(7)
    end
  end
end
