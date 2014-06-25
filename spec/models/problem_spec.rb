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

require "spec_helper"
require "rake"

describe Problem, type: :model do
  let(:user) { create(:user) }
  describe "Associations" do
    it { is_expected.to belong_to(:unit) }
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

      it "has no unit" do
        expect(problem_factory.problem.unit).to be nil
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

      it "has no unit" do
        expect(problem_factory.problem.unit).to be nil
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

      it "has no unit" do
        expect(problem_factory.problem.unit).to be nil
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

      it "has no unit" do
        expect(problem_factory.problem.unit).to be nil
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

      it "has no unit" do
        expect(problem_factory.problem.unit).to be nil
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

  describe ConcentrationAmount do
    let(:problem_factory) { ProblemFactory.new("ConcentrationAmount", user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(ConcentrationAmount)
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

  describe ConcentrationTablet do
    let(:problem_factory) { ProblemFactory.new("ConcentrationTablet", user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(ConcentrationTablet)
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

  describe ConcentrationToHundred do
    let(:problem_factory) { ProblemFactory.new("ConcentrationToHundred", user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(ConcentrationToHundred)
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

  describe SyringePumpAmount do
    let(:problem_factory) { ProblemFactory.new("SyringePumpAmount", user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(SyringePumpAmount)
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

  describe SyringePumpHourly do
    let(:problem_factory) { ProblemFactory.new("SyringePumpHourly", user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(SyringePumpHourly)
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

  describe DropIvHourly do
    let(:problem_factory) { ProblemFactory.new("DropIvHourly", user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(DropIvHourly)
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

  describe DropIvAmount do
    let(:problem_factory) { ProblemFactory.new("DropIvAmount", user) }

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(DropIvAmount)
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

  describe UnitConversion do
    let(:grams) { UnitGroup.create(name: "grams") }
    let(:liters) { UnitGroup.create(name: "liters") }

    let(:ml) { Unit.create(name: "Milliter", sign: "ml", unit_group: liters) }
    let(:cl) { Unit.create(name: "Centiliter", sign: "cl", unit_group: liters) }
    let(:dl) { Unit.create(name: "Deciliter", sign: "dl", unit_group: liters) }
    let(:l) { Unit.create(name: "Liter", sign: "l", unit_group: liters) }
    let(:mg) { Unit.create(name: "Milligram", sign: "mg", unit_group: grams) }
    let(:cg) { Unit.create(name: "Centigram", sign: "cg", unit_group: grams) }
    let(:dg) { Unit.create(name: "Decigram", sign: "dg", unit_group: grams) }
    let(:g) { Unit.create(name: "Gram", sign: "g", unit_group: grams) }
    let(:dag) { Unit.create(name: "Decagram", sign: "dag", unit_group: grams) }
    let(:hg) { Unit.create(name: "Hectogram", sign: "hg", unit_group: grams) }
    let(:kg) { Unit.create(name: "Kilogram", sign: "kg", unit_group: grams) }

    let(:challenge) { Challenge.new(name: "UnitConversion") }
    let(:problem_factory) { ProblemFactory.new(challenge.name, user) }

    before :each do
      ml.reload
      cl.reload
      dl.reload
      l.reload
      mg.reload
      cg.reload
      dg.reload
      g.reload
      dag.reload
      hg.reload
      kg.reload
      grams.reload
      liters.reload
    end

    it "creates a problem" do
      expect(problem_factory.problem).to be_a(UnitConversion)
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
