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

require 'spec_helper'

describe Problem do
  describe "Associations" do
    it { should belong_to(:unit) }
  end

  describe "Methods" do
    before :each do
      Skill.create(name:"Addition")
      Skill.create(name:"Division")
      Skill.create(name:"Multiplication")
      Skill.create(name:"Subtraction")
    end

    it "should create a Problem with amount of steps equal to difficulty" do
      difficulty = rand(1...10)
      problem = Problem.generate_random(difficulty)
      expect(problem.get_result).to be_a(Float)
    end
  end

  describe PercentageAmountOfAmount do
    let(:challenge) { AdvancedChallenge.new(name: "PercentageAmountOfAmount") }
    let(:problem_factory) { ProblemFactory.new(challenge.name) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(PercentageAmountOfAmount)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end
    end
  end

  describe PercentageOfUnit do
    let(:challenge) { AdvancedChallenge.new(name: "PercentageOfUnit") }
    let(:problem_factory) { ProblemFactory.new(challenge.name) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(PercentageOfUnit)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end
    end
  end
  describe PercentageUnitToHundred do
    let(:challenge) { AdvancedChallenge.new(name: "PercentageUnitToHundred") }
    let(:problem_factory) { ProblemFactory.new(challenge.name) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(PercentageUnitToHundred)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end
    end
  end
  describe SolutionMaxisporin do
    let(:challenge) { AdvancedChallenge.new(name: "SolutionMaxisporin") }
    let(:problem_factory) { ProblemFactory.new(challenge.name) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(SolutionMaxisporin)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end
    end
  end
end
