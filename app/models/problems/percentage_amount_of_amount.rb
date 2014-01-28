# == Schema Information
#
# Table name: problems
#
#  id             :integer          not null, primary key
#  formula        :string(255)
#  question       :string(255)
#  theory         :text
#  difficulty     :float
#  created_at     :datetime
#  updated_at     :datetime
#  unit_id        :integer
#  type           :string(255)
#  result         :float
#  skill_id       :integer
#  max_difficulty :integer          default(100)
#  skill_offset   :integer          default(10)
#

class PercentageAmountOfAmount < Problem
  def generate(user)
    self.max_difficulty = 35
    super(user)
  end

  def info
    I18n.t("problem_info.PercentageAmountOfAmount")
  end

  def generate_formula
    operations = Array(Operation.new(
                      AVAILABLE_OPERATORS["Multiplication"],
                      Constant.new(Float((rand(1...10)*10))/100),
                      Constant.new(Float(1 + rand(1..1000)).round(2))
                    ))
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = "#{formula.operations[0].constant1.value*100}% van #{formula.operations[0].constant2.value}#{unit.sign}"
  end
end
