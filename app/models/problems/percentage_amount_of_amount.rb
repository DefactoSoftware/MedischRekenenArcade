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

class PercentageAmountOfAmount < Problem
  def self.generate
    unit = AVAILABLE_UNITS[rand(0...AVAILABLE_UNITS.length)]
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Multiplication"],
                    Constant.new(Float((rand(1...10)*10))/100),
                    Constant.new(Float(1 + rand(1...4)).round(2))
                  )
    formula = Formula.new(operations)

    theory = "#{operations[0].constant1.value*100}% van #{operations[0].constant2.value}#{unit}"

    self.create(theory:theory, unit: Unit.where(sign:unit).first, result: formula.result)
  end

  def info
    I18n.t("problem_info.PercentageAmountOfAmount")
  end
end
