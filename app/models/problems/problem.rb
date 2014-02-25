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

require 'formula'

class Problem < ActiveRecord::Base
  belongs_to :skill
  has_many :answers, dependent: :destroy
  belongs_to :unit


  AVAILABLE_OPERATORS = { "Addition" => :+, "Division" => :/, "Multiplication" => :*, "Subtraction" => :- }
  AVAILABLE_UNITS = ["mg", "gr", "kg", "ml", "cl", "dl", "l"]

  VALID_PROBLEMS = %w(PercentageAmountOfAmount PercentageOfUnit PercentageUnitToHundred SolutionMaxisporin
                      Division Multiplication Addition Subtraction Mixed UnitConversion ConcentrationTablet
                      ConcentrationAmount ConcentrationToHundred)

  def generate(user)
    generate_unit
    generate_skill

    user_skill = UserSkill.where(skill: skill, user: user).first_or_create

    formula = lazy_generate(user_skill.level)

    generate_theory(formula)
    generate_result(formula)

    self.save
    self
  end

  def compare_skill_difficulty(level, formula)
    (level-skill_offset..level+skill_offset).include?(formula.difficulty) || level > max_difficulty
  end

  def generate_skill
    self.skill = Skill.where(name: self.class.name).first_or_create
  end

  def generate_unit
    self.unit = Unit.where(sign:AVAILABLE_UNITS[rand(0...AVAILABLE_UNITS.length)]).first_or_create
  end

  def generate_result(formula)
    self.result = formula.result
  end

  def lazy_generate(level)
    valid = false
    max_tries = 1000
    index = 0
    while !valid && index < max_tries
      formula = generate_formula
      valid = compare_skill_difficulty(level, formula)
      index += 1
    end
    formula
  end

  def get_result
    result.round(2)
  end

  def info
    I18n.t("problem_info.basic")
  end
end
