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

class SolutionMaxisporin < Problem
  def generate_unit
    self.unit = Unit.where(sign: "ml").first_or_create
  end

  def generate_formula
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(Float(0.25 + rand(1...9) * 0.25).round(2)*1000),
                    Constant.new(Float(1 + rand(1...4)).round(2))
                  )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(Float(0.1 + rand(1...22) * 0.1).round(2)*1000),
                    Constant.new(Float(0.1 + rand(1...9) * 0.2).round(2))
                  )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(operations[0]),
                    Constant.new(operations[1])
                  )
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = I18n.t("problems.theory.#{self.class.name}",
                          operation1_constant1: formula.operations[0].constant1.value,
                          operation1_constant2: formula.operations[0].constant2.value,
                          operation2_constant1: formula.operations[1].constant1.value,
                          operation2_constant2: formula.operations[1].constant2.value,
                          unit: unit.sign,
                          unit_question: "mg"
                        )
  end

  def info
    I18n.t("problem_info.SolutionMaxisporin")
  end
end
