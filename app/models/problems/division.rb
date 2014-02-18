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

class Division < Problem
  def generate_unit
    self.unit = nil
  end

  def generate_formula
    operations = Array(Operation.new(
                      AVAILABLE_OPERATORS["Division"],
                      Constant.new(Float((rand(5...100)*10))),
                      Constant.new(Float(5 * rand(1..10)).round(2))
                    ))
    formula = Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = "#{formula.operations[0].constant1.value} #{formula.operations[0].operator} #{formula.operations[0].constant2.value}"
  end
end
