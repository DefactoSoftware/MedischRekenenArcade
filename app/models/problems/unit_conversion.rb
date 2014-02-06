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

class UnitConversion < Problem
  def generate_formula
    weight_range = UnitGroup.where(name: 'grams').first
    volume_range = UnitGroup.where(name: 'liters').first
    ranges = [weight_range, volume_range]
    range = ranges.sample

    self.unit_question = range.units.sample
    until self.unit && self.unit_question.sign != self.unit.sign && unit.unit_group == unit_question.unit_group do
      self.unit = range.units.sample
    end

    operations = Array(Operation.new(
                    :*,
                    Constant.new(Float(rand(1..100) + (10 ** (range.units.index(unit) - range.units.index(unit_question)).abs))),
                    Constant.new(Float(10 ** (range.units.index(unit_question) - range.units.index(unit))))
                  ))
    return Formula.new(operations)
  end

  def generate_theory(formula)
    self.theory = I18n.t("problems.theory.#{self.class.name}",
                          constant1: formula.operations[0].constant1.value,
                          unit: unit.sign,
                          unit_question: unit_question.sign
                        )
  end

  def info
    I18n.t("problem_info.UnitConversion")
  end
end
