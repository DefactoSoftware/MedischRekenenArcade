task :create_basic_challenges => :environment do
  adding = Skill.where(name: "adding").first_or_create
  dividing = Skill.where(name: "dividing").first_or_create
  multiplying = Skill.where(name: "multiplying").first_or_create
  subtracting = Skill.where(name: "subtracting").first_or_create

  addition_challenge = BasicChallenge.where(name: "Addition 1", number_of_problems: 10, steps: 1, timelimit: 900000, bonus: 20, icon: "http://www.freewebs.com/workstattion/MATH/addition%20and%20subtraction/ADDITION.gif").first_or_create
  two_addition_challenge = BasicChallenge.where(name: "Addition 2", number_of_problems: 10, steps: 2, timelimit: 900000, bonus: 30, icon: "http://www.freewebs.com/workstattion/MATH/addition%20and%20subtraction/ADDITION.gif").first_or_create
  three_addition_challenge = BasicChallenge.where(name: "Addition 3", number_of_problems: 10, steps: 3, timelimit: 900000, bonus: 40, icon: "http://www.freewebs.com/workstattion/MATH/addition%20and%20subtraction/ADDITION.gif").first_or_create

  division_challenge = BasicChallenge.where(name: "Division 1", number_of_problems: 10, steps: 1, timelimit: 900000, bonus: 20, icon: "http://comps.canstockphoto.com/can-stock-photo_csp5062654.jpg").first_or_create
  two_division_challenge = BasicChallenge.where(name: "Division 2", number_of_problems: 10, steps: 2, timelimit: 900000, bonus: 30, icon: "http://comps.canstockphoto.com/can-stock-photo_csp5062654.jpg").first_or_create
  three_division_challenge = BasicChallenge.where(name: "Division 3", number_of_problems: 10, steps: 3, timelimit: 900000, bonus: 40, icon: "http://comps.canstockphoto.com/can-stock-photo_csp5062654.jpg").first_or_create

  multiplication_challenge = BasicChallenge.where(name: "Multiplication 1", number_of_problems: 10, steps: 1, timelimit: 900000, bonus: 20, icon: "http://kvanantwerp.edublogs.org/files/2012/11/Multiplication-2h5m7l8.jpeg").first_or_create
  two_multiplication_challenge = BasicChallenge.where(name: "Multiplication 2", number_of_problems: 10, steps: 2, timelimit: 900000, bonus: 30, icon: "http://kvanantwerp.edublogs.org/files/2012/11/Multiplication-2h5m7l8.jpeg").first_or_create
  three_multiplication_challenge = BasicChallenge.where(name: "Multiplication 3", number_of_problems: 10, steps: 3, timelimit: 900000, bonus: 40, icon: "http://kvanantwerp.edublogs.org/files/2012/11/Multiplication-2h5m7l8.jpeg").first_or_create

  subtraction_challenge = BasicChallenge.where(name: "Subtraction 1", number_of_problems: 10, steps: 1, timelimit: 900000, bonus: 20, icon: "http://www.freewebs.com/workstattion/MATH/addition%20and%20subtraction/SBTRCTIN.gif").first_or_create
  two_subtraction_challenge = BasicChallenge.where(name: "Subtraction 2", number_of_problems: 10, steps: 2, timelimit: 900000, bonus: 30, icon: "http://www.freewebs.com/workstattion/MATH/addition%20and%20subtraction/SBTRCTIN.gif").first_or_create
  three_subtraction_challenge = BasicChallenge.where(name: "Subtraction 3", number_of_problems: 10, steps: 3, timelimit: 900000, bonus: 40, icon: "http://www.freewebs.com/workstattion/MATH/addition%20and%20subtraction/SBTRCTIN.gif").first_or_create

  mixed_challenge = BasicChallenge.where(name: "Mixed 1", number_of_problems: 10, steps:1, timelimit: 900000, bonus: 20, icon: "http://heath.weblab.brookline.k12.ma.us/math/calendar/math.jpg").first_or_create
  two_mixed_challenge = BasicChallenge.where(name: "Mixed 2", number_of_problems: 10, steps:2, timelimit: 900000, bonus: 30, icon: "http://heath.weblab.brookline.k12.ma.us/math/calendar/math.jpg").first_or_create
  three_mixed_challenge = BasicChallenge.where(name: "Mixed 3", number_of_problems: 10, steps:3, timelimit: 900000, bonus: 40, icon: "http://heath.weblab.brookline.k12.ma.us/math/calendar/math.jpg").first_or_create

  ChallengeSkill.where(skill: adding, challenge: addition_challenge).first_or_create
  ChallengeSkill.where(skill: adding, challenge: two_addition_challenge).first_or_create
  ChallengeSkill.where(skill: adding, challenge: three_addition_challenge).first_or_create

  ChallengeSkill.where(skill: dividing, challenge: division_challenge).first_or_create
  ChallengeSkill.where(skill: dividing, challenge: two_division_challenge).first_or_create
  ChallengeSkill.where(skill: dividing, challenge: three_division_challenge).first_or_create

  ChallengeSkill.where(skill: multiplying, challenge: multiplication_challenge).first_or_create
  ChallengeSkill.where(skill: multiplying, challenge: two_multiplication_challenge).first_or_create
  ChallengeSkill.where(skill: multiplying, challenge: three_multiplication_challenge).first_or_create

  ChallengeSkill.where(skill: subtracting, challenge: subtraction_challenge).first_or_create
  ChallengeSkill.where(skill: subtracting, challenge: two_subtraction_challenge).first_or_create
  ChallengeSkill.where(skill: subtracting, challenge: three_subtraction_challenge).first_or_create

  ChallengeSkill.where(skill: subtracting, challenge: mixed_challenge).first_or_create
  ChallengeSkill.where(skill: adding, challenge: mixed_challenge).first_or_create
  ChallengeSkill.where(skill: multiplying, challenge: mixed_challenge).first_or_create
  ChallengeSkill.where(skill: dividing, challenge: mixed_challenge).first_or_create
  ChallengeSkill.where(skill: subtracting, challenge: two_mixed_challenge).first_or_create
  ChallengeSkill.where(skill: adding, challenge: two_mixed_challenge).first_or_create
  ChallengeSkill.where(skill: multiplying, challenge: two_mixed_challenge).first_or_create
  ChallengeSkill.where(skill: dividing, challenge: two_mixed_challenge).first_or_create
  ChallengeSkill.where(skill: subtracting, challenge: three_mixed_challenge).first_or_create
  ChallengeSkill.where(skill: adding, challenge: three_mixed_challenge).first_or_create
  ChallengeSkill.where(skill: multiplying, challenge: three_mixed_challenge).first_or_create
  ChallengeSkill.where(skill: dividing, challenge: three_mixed_challenge).first_or_create
end
