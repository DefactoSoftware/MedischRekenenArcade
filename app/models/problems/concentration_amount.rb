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

class ConcentrationAmount < Problem
  def generate_unit
    self.unit = Unit.where(sign: "gr").first_or_create
  end

  def generate_formula
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Multiplication"],
                    Constant.new(Float(rand(1..10)*100)),
                    Constant.new(Float((0.1*rand(1..50)).round(2))/100)
                  )
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    medicine = ["glucose", "natriumchloride"]
    self.theory = I18n.t("problems.theory.#{self.class.name.underscore}.#{medicine.sample}",
                          operation1_constant1: formula.operations[0].constant1.value,
                          operation1_constant2: (formula.operations[0].constant2.value*100).round(2)
                        )
  end
end
