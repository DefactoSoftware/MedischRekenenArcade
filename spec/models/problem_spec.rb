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

require 'spec_helper'
require 'rake'

describe Problem do
  let(:user) { FactoryGirl.create(:user) }
  describe "Associations" do
    it { should belong_to(:unit) }
  end

  describe Division do
    let(:challenge) { Challenge.new(name: "Division") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(Division)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end

  describe Subtraction do
    let(:challenge) { Challenge.new(name: "Subtraction") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(Subtraction)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end

  describe Addition do
    let(:challenge) { Challenge.new(name: "Addition") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(Addition)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end

  describe Multiplication do
    let(:challenge) { Challenge.new(name: "Multiplication") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(Multiplication)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end

  describe Mixed do
    let(:challenge) { Challenge.new(name: "Mixed") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(Mixed)
    end

    describe "problem" do
      it "has a theory" do
        expect(problem_factory.problem.theory).to be_a(String)
      end

      it "has a result" do
        expect(problem_factory.problem.get_result).to be_a(Float)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end


  describe PercentageAmountOfAmount do
    let(:unit) { Unit.create(name: "Milliliter") }
    let(:challenge) { Challenge.new(name: "PercentageAmountOfAmount") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

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

      it "has a unit" do
        expect(problem_factory.problem.unit).to be_a(Unit)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end

  describe PercentageOfUnit do
    let(:unit) { Unit.create(name: "Milliliter") }
    let(:challenge) { Challenge.new(name: "PercentageOfUnit") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

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

      it "has a unit" do
        expect(problem_factory.problem.unit).to be_a(Unit)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end
  describe PercentageUnitToHundred do
    let(:challenge) { Challenge.new(name: "PercentageUnitToHundred") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

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

      it "has a unit" do
        expect(problem_factory.problem.unit).to be_a(Unit)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end
  describe SolutionMaxisporin do
    let(:challenge) { Challenge.new(name: "SolutionMaxisporin") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

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

      it "has a unit" do
        expect(problem_factory.problem.unit).to be_a(Unit)
      end

      it "has a skill" do
        expect(problem_factory.problem.skill).to be_a(Skill)
      end
    end
  end
end
