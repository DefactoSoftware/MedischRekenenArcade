class SkillSuggester
  def initialize(user)
    @user = user
  end

  def skill
    skills = @user.user_skills
    lowest = skills.first
    skills.each do |skill|
      lowest = skill if skill.level < lowest.level
    end
    lowest ? lowest.skill : nil
  end
end
