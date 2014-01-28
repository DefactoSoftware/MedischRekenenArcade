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

class PercentageUnitToHundred < Problem
  def generate_formula
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(Float(rand(1...100)).round(2)),
                    Constant.new(Float(rand(1...100)).round(2))
                )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Multiplication"],
                    Constant.new(operations.last),
                    Constant.new(100)
                )
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    unit_question = "%";
    self.theory = "#{formula.operations[0].constant2.value}#{unit_question} is #{formula.operations[0].constant1.value}#{unit.sign}, hoeveel is #{formula.operations[1].constant2.value}#{unit_question}"
  end

  def info
    I18n.t("problem_info.PercentageUnitToHundred")
  end
end
