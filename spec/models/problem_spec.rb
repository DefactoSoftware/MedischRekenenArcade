# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  formula    :string(255)
#  question   :string(255)
#  theory     :string(255)
#  difficulty :float
#  unit       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Problem do
  describe "Associations" do
    it { should have_many(:steps) }
  end



  describe "Methods" do
    before :each do
      Skill.create(name:"adding")
      Skill.create(name:"dividing")
      Skill.create(name:"multiplying")
      Skill.create(name:"subtracting")
    end

    it "should create a Problem with amount of steps equal to difficulty" do
      difficulty = rand(1...10)
      problem = Problem.generate_random(difficulty)
      expect(problem.steps.count).to eq(difficulty)
      problem.steps.each do |step|
        puts step.formula
        puts step.get_result
      end
      puts problem.formula
      puts problem.get_result
    end

  end
end
