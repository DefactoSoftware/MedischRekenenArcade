class SkillSuggester
  def initialize(user)
    @user = user
  end

  def skill
    skills = UserSkill.where(user: @user)
    lowest = skills.first
    skills.each do |skill|
      lowest = skill if skill.level < lowest.level
    end
    lowest.skill
  end
end
