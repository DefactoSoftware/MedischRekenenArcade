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

class Subtraction < Problem
  def generate_unit
    self.unit = nil
  end

  def generate_formula
    operations = Array(Operation.new(
                      AVAILABLE_OPERATORS["Subtraction"],
                      Constant.new(Float(rand(50..300))),
                      Constant.new(Float(rand(1..50)))
                    ))
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = "#{formula.operations[0].constant1.value} #{formula.operations[0].operator} #{formula.operations[0].constant2.value}"
  end
end
