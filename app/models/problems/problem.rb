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

require 'formula'

class Problem < ActiveRecord::Base
  has_many :skills
  belongs_to :unit

  AVAILABLE_OPERATORS = { "Addition" => :+, "Division" => :/, "Multiplication" => :*, "Subtraction" => :- }
  AVAILABLE_UNITS = ["mg", "g", "kg", "ml", "cl", "dl", "l"]

  VALID_PROBLEMS = %w(PercentageAmountOfAmount PercentageOfUnit PercentageUnitToHundred SolutionMaxisporin)

  def get_result
    result.round(2)
  end

  def info
    I18n.t("problem_info.basic")
  end

  def self.generate_random(steps)
    problem = self.create
    operations = []
    steps.times do
      constant1 = operations.length > 0 ? Constant.new(operations.last) : Constant.new(Float(rand(1...100)))
      constant2 = Constant.new(Float(rand(1...100)))
      operations << Operation.new(AVAILABLE_OPERATORS.to_a.sample[1], constant1, constant2)
    end
    formula = Formula.new(operations)
    problem.update_attributes(theory: formula.text, result: formula.result)
    problem
  end

  def self.generate_random_with_skills(steps, skills)
    problem = self.create
    operations = []
    steps.times do
      constant1 = operations.length > 0 ? Constant.new(operations.last) : Constant.new(Float(rand(1...100)))
      constant2 = Constant.new(Float(rand(1...100)))
      operations << Operation.new(AVAILABLE_OPERATORS[skills.sample.name], constant1, constant2)
    end
    formula = Formula.new(operations)
    problem.update_attributes(theory: formula.text, result: formula.result)
    problem
  end
end
