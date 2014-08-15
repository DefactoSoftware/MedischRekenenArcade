require "spec_helper"

describe ProblemSerializer do
  let(:problem1) { create(:subtraction) }
  let(:problem2) { create(:oxygen_time) }

  describe "#serialize" do
    it "serializes the problem without unit" do
      serializer = ProblemSerializer.new(problem1)
      expect(serializer.to_json).to(
        include_json(serialized_problem_without_unit.to_json))
    end

    it "serializes the problem with unit" do
      serializer = ProblemSerializer.new(problem2)
      expect(serializer.to_json).to(
        include_json(serialized_problem_with_unit.to_json))
    end
  end

  def serialized_problem_with_unit
    {
      id: problem2.id,
      theory: problem2.theory,
      result: problem2.result,
      unit: { id: problem2.unit.id, sign: problem2.unit.sign }
    }
  end

  def serialized_problem_without_unit
    {
      id: problem1.id,
      theory: problem1.theory,
      result: problem1.result,
      unit: nil
    }
  end
end
