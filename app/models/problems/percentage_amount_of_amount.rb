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
#  max_difficulty :integer          default(35)
#  skill_offset   :integer          default(10)
#  unit_question  :string(255)
#

class PercentageAmountOfAmount < Problem
  def info
    I18n.t("problem_info.PercentageAmountOfAmount")
  end

  def generate_formula
    operations = []
    operations << Operation.new(
                      AVAILABLE_OPERATORS["Multiplication"],
                      Constant.new(Float((rand(1...10)*10))/100),
                      Constant.new(Float(1 + rand(1..1000)).round(2))
                    )
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = I18n.t("problems.theory.#{self.class.name}",
                          operation1_constant1: formula.operations[0].constant1.value*100,
                          operation1_constant2: formula.operations[0].constant2.value,
                          unit: unit.sign
                        )
  end
end
