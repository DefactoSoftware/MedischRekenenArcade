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

class PercentageOfUnit < Problem
  def info
    I18n.t("problem_info.PercentageOfUnit")
  end

  def generate_unit
    self.unit = Unit.where(sign:"%").first_or_create
  end

  def generate_formula
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(Float(rand(1...50)).round(2)),
                    Constant.new(Float(rand(6...10)*10).round(2))
                  )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Multiplication"],
                    Constant.new(operations.last),
                    Constant.new(100)
                )
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    unit_question = AVAILABLE_UNITS[rand(0...AVAILABLE_UNITS.length)]
    self.theory = I18n.t("problems.theory.#{self.class.name}",
                          operation1_constant1: formula.operations[0].constant1.value,
                          operation1_constant2: formula.operations[0].constant2.value,
                          unit: unit.sign,
                          unit_question: unit_question
                        )
  end
end
