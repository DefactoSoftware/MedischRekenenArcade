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
  def self.generate(user)
    unit = AVAILABLE_UNITS[rand(0...AVAILABLE_UNITS.length)]

    skill = Skill.where(name: "PercentageAmountOfAmount").first_or_create
    user_skill = UserSkill.where(skill: skill, user: user).first_or_create

    valid = false
    operations = []
    new_formula = Formula.new(operations)
    while !valid
      puts "JEMOEDER"
      operations << Operation.new(
                      AVAILABLE_OPERATORS["Multiplication"],
                      Constant.new(Float((rand(1...1000)*10))/100),
                      Constant.new(Float(1 + rand(1...40)).round(2))
                    )
      new_formula = Formula.new(operations)
      puts new_formula
      valid = (user_skill.level-10..user_skill.level+10).include?(new_formula.difficulty)
    end

    theory = "#{new_formula.operations[0].constant1.value*100}% van #{new_formula.operations[0].constant2.value}#{unit}"

    problem = self.create(theory:theory, unit: Unit.where(sign:unit).first, result: formula.result, skills: [skill])
    problem.skills << skill
  end

  def info
    I18n.t("problem_info.PercentageAmountOfAmount")
  end
end
