task :create_basic_challenges => :environment do
  adding = Skill.where(name: "adding").first_or_create
  dividing = Skill.where(name: "dividing").first_or_create
  multiplying = Skill.where(name: "multiplying").first_or_create
  subtracting = Skill.where(name: "subtracting").first_or_create

  addition_challenge = Challenge.where(name: "Addition", number_of_problems: 10, timelimit: 900000, bonus: 20, icon: "http://www.freewebs.com/workstattion/MATH/addition%20and%20subtraction/ADDITION.gif").first_or_create
  division_challenge = Challenge.where(name: "Division", number_of_problems: 10, timelimit: 900000, bonus: 20, icon: "http://comps.canstockphoto.com/can-stock-photo_csp5062654.jpg").first_or_create
  multiplication_challenge = Challenge.where(name: "Multiplication", number_of_problems: 10, timelimit: 900000, bonus: 20, icon: "http://kvanantwerp.edublogs.org/files/2012/11/Multiplication-2h5m7l8.jpeg").first_or_create
  subtraction_challenge = Challenge.where(name: "Subtraction", number_of_problems: 10, timelimit: 900000, bonus: 20, icon: "http://www.freewebs.com/workstattion/MATH/addition%20and%20subtraction/SBTRCTIN.gif").first_or_create

  ChallengeSkill.where(skill: adding, challenge: addition_challenge).first_or_create
  ChallengeSkill.where(skill: dividing, challenge: division_challenge).first_or_create
  ChallengeSkill.where(skill: multiplying, challenge: multiplication_challenge).first_or_create
  ChallengeSkill.where(skill: subtracting, challenge: subtraction_challenge).first_or_create
end
