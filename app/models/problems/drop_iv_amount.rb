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

class DropIvAmount < Problem
  STANDARD_DROP_AMOUNT = 20
  def generate_unit
    self.unit = Unit.where(sign: "dr").first_or_create
  end

  def generate_formula
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Multiplication"],
                    Constant.new(Float(0.5*rand(2..10)).round(2)),
                    Constant.new(Float(1000))
                )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(operations.last),
                    Constant.new(Float(24*60))
                )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Multiplication"],
                    Constant.new(operations.last),
                    Constant.new(STANDARD_DROP_AMOUNT)
                )
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = I18n.t("problems.theory.#{self.class.name}",
                          unit: unit.sign,
                          operation1_constant1: formula.operations[0].constant1.value
                        )
  end

  def info
    I18n.t("problem_info.DropIvAmount")
  end
end
