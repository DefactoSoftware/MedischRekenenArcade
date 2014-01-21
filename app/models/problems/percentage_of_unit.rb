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

class PercentageOfUnit < Problem
  def self.generate
    unit_question = AVAILABLE_UNITS[rand(0...AVAILABLE_UNITS.length)]
    unit = "%"
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(Float(rand(1...50)).round(2)),
                    Constant.new(Float(rand(6...10)*10).round(2))
                  )
    formula = Formula.new(operations)

    theory = "Hoeveel % is #{operations[0].constant1.value}#{unit_question} van #{operations[0].constant2.value}#{unit_question}"

    self.create(theory:theory, unit: Unit.where(sign:unit).first, result: formula.result)
  end
  def info
    I18n.t("problem_info.PercentageOfUnit")
  end
end
