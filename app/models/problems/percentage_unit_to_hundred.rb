# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  formula    :string(255)
#  question   :string(255)
#  theory     :text
#  difficulty :float
#  created_at :datetime
#  updated_at :datetime
#  unit_id    :integer
#  type       :string(255)
#  result     :float
#

class PercentageUnitToHundred < Problem
  def self.generate
    unit = AVAILABLE_UNITS[rand(0...AVAILABLE_UNITS.length)]
    unit_question = "%";

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
    theory = "#{operations[0].constant2.value}#{unit_question} is #{operations[0].constant1.value}#{unit}, hoeveel is #{operations[1].constant2.value}#{unit_question}"
    self.create(theory:theory, unit: Unit.where(sign:unit).first, result: formula.result)
  end
end
