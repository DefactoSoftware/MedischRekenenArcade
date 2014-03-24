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

class OxygenPressure < Problem
  def generate_unit
    self.unit = Unit.where(sign: "bar").first
  end

  def generate_formula
    operations = []
    operations << Operation.new(
                      AVAILABLE_OPERATORS["Division"],
                      Constant.new(Float((rand(1...10)*100).round(2))),
                      Constant.new(Float((rand(3..10)*0.5).round(2)))
                    )
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = I18n.t("problems.theory.#{self.class.name.underscore}",
                          operation1_constant1: formula.operations[0].constant1.value,
                          operation1_constant2: formula.operations[0].constant2.value
                        )
  end
end
