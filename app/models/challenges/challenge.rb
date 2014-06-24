# == Schema Information
#
# Table name: challenges
#
#  id                 :integer          not null, primary key
#  number_of_problems :integer
#  name               :string(255)
#  timelimit          :integer
#  bonus              :integer
#  icon               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  steps              :integer
#  type               :string(255)
#  challenge_set_id   :integer
#
require "problem_factory"

class Challenge < ActiveRecord::Base
  has_many :challenge_skills
  has_many :skills, through: :challenge_skills
  has_many :user_challenges
  belongs_to :challenge_set

  VALID_NAMES =  %w(PercentageAmountOfAmount PercentageOfUnit
                    PercentageUnitToHundred Division
                    Addition Subtraction Multiplication
                    Mixed UnitConversion ConcentrationTablet
                    ConcentrationToHundred ConcentrationAmount
                    SolutionMaxisporin SyringePumpAmount
                    SyringePumpHourly DropIvHourly DropIvAmount
                    OxygenTime OxygenPressure)

  validates :name, inclusion: { in: VALID_NAMES }

  def total_correct_answers_for_user(user)
    userchallenges = user_challenges.where(user: user)
    userchallenges.inject(0) do |total, userchallenge|
      total + userchallenge.amount_good
    end
  end

  def total_incorrect_answers_for_user(user)
    userchallenges = user_challenges.where(user: user)
    userchallenges.inject(0) do |total, userchallenge|
      total + userchallenge.amount_fail
    end
  end

  def total_success_for_user(user)
    user_challenges.where(user: user, success: true).count
  end

  def total_failed_for_user(user)
    user_challenges.where(user: user, success: false || nil).count
  end

  def create_problem(user)
    ProblemFactory.new(name, user).problem
  end
end
