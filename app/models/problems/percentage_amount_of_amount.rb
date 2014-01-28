# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  formula    :string(255)
#  question   :string(255)
#  theory     :text
#  difficulty :float
#  created_at :datetime
#  updated_at :datetime
#  unit_id    :integer
#  type       :string(255)
#  result     :float
#

class PercentageAmountOfAmount < Problem
  SKILL_LEVEL_OFFSET = 10

  def generate(user)
    super(user)

    user_skill = UserSkill.where(skill: skill, user: user).first_or_create

    formula = lazy_generate(user_skill.level)

    create_theory(formula)
    create_result(formula)

    self.save
    self
  end

  def info
    I18n.t("problem_info.PercentageAmountOfAmount")
  end

  def lazy_generate(level)
    valid = false
    while !valid
      formula = create_formula
      valid = compare_skill_difficulty(level, formula.difficulty)
    end
    formula
  end

  def create_formula
    operations = Array(Operation.new(
                      AVAILABLE_OPERATORS["Multiplication"],
                      Constant.new(Float((rand(1...10)*10))/100),
                      Constant.new(Float(1 + rand(1..10000)).round(2))
                    ))
    formula = Formula.new(operations)
  end

  def compare_skill_difficulty(level, difficulty)
    (level-SKILL_LEVEL_OFFSET..level+SKILL_LEVEL_OFFSET).include?(difficulty)
  end

  def create_result(formula)
    self.result = formula.result
  end

  def create_theory(formula)
    self.theory = "#{formula.operations[0].constant1.value*100}% van #{formula.operations[0].constant2.value}#{unit.sign}"
  end
end
