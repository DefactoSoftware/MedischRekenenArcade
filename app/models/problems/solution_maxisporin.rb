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

class SolutionMaxisporin < Problem
  def self.generate
    unit = "ml";
    operations = []
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(Float(0.25 + rand(1...9) * 0.25).round(2)),
                    Constant.new(Float(1 + rand(1...4)).round(2))
                  )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(Float(0.1 + rand(1...22) * 0.1).round(2)),
                    Constant.new(Float(0.1 + rand(1...9) * 0.2).round(2))
                  )
    operations << Operation.new(
                    AVAILABLE_OPERATORS["Division"],
                    Constant.new(operations[0]),
                    Constant.new(operations[1])
                  )
    formula = Formula.new(operations)
    theory = "Geef een patient parentaal #{operations[0].constant1.value} Maxisporin per dag, verdeeld over #{operations[0].constant2.value} injecties." +
             "In voorraad is Maxisporin #{operations[1].constant1.value}. Dit poeder dient opgelost te worden in 4ml aqua bidestillata" +
             "ter verkrijging van #{operations[1].constant2.value} injectievloeistof. \n Hoeveel #{unit} injecteer je per keer?"
    self.create(theory:theory, unit: Unit.where(sign:unit).first, result: formula.result)
  end
end
