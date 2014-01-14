class ProblemGenerator
  AVAILABLE_SKILLS = ["adding", "dividing", "multiplying", "subtracting"]
  AVAILABLE_UNITS = ["mg", "g", "kg", "ml", "cl", "dl", "l"]

  attr_reader :challenge, :unit

  def initialize(challenge)
    @unit = AVAILABLE_UNITS[rand(0...AVAILABLE_UNITS.length)]
    @challenge = challenge
  end
end
