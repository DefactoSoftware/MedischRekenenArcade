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

class OxygenTime < Problem
  def generate_unit
    self.unit = Unit.where(sign: "min").first
  end

  def generate_formula
    operations = []
    operations << Operation.new(
                      AVAILABLE_OPERATORS["Multiplication"],
                      Constant.new(Float(rand(1...10).round(2))),
                      Constant.new(Float((rand(5..9)*15).round(2)))
                    )
    operations << Operation.new(
                      AVAILABLE_OPERATORS["Division"],
                      Constant.new(operations.last),
                      Constant.new(Float(rand(2...6)*0.5).round(2))
    )
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = I18n.t("problems.theory.#{self.class.name.underscore}",
                          operation1_constant1: formula.operations[0].constant1.value,
                          operation1_constant2: formula.operations[0].constant2.value,
                          operation2_constant1: formula.operations[1].constant2.value
                        )
  end
end
