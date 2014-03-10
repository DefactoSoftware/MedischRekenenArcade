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

class ConcentrationTablet < Problem
  def generate_unit
    self.unit = Unit.where(sign: "%").first_or_create
  end

  def generate_formula
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(Float(rand(1...10)*50)),
                    Constant.new(Float(rand(5...20)*100))
                  )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Multiplication"],
                    Constant.new(operations.last),
                    Constant.new(Float(100))
                  )
    formula = Formula.new(operations)

  end

  def generate_theory(formula)
    medicine = ["vitaminc", "augmentin_amoxicilline", "augmentin_clavulaneacid", "methylfenidaat"]
    self.theory = I18n.t("problems.theory.#{self.class.name}.#{medicine.sample}",
                          operation1_constant1: formula.operations[0].constant2.value,
                          operation1_constant2: formula.operations[0].constant1.value,
                          operation2_constant1: formula.operations[1].constant2.value
                        )
  end

  def info
    I18n.t("problem_info.ConcentrationTablet")
  end
end
