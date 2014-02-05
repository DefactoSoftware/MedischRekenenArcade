task :create_basic_challenges => :environment do
  STANDARD_NO_PROBLEMS = 10
  adding = Skill.where(name: "Addition").first_or_create
  dividing = Skill.where(name: "Division").first_or_create
  multiplying = Skill.where(name: "Multiplication").first_or_create
  subtracting = Skill.where(name: "Subtraction").first_or_create
  percentage = Skill.where(name: "percentage").first_or_create
  unitconversion = Skill.where(name: "unitconversion").first_or_create

  addition_challenge = BasicChallenge.where(name: "Addition_1", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Optellen.png").first_or_create
  two_addition_challenge = BasicChallenge.where(name: "Addition_2", number_of_problems: STANDARD_NO_PROBLEMS, steps: 2, timelimit: 900000, bonus: 30, icon: "challenges/Menu_Optellen.png").first_or_create
  three_addition_challenge = BasicChallenge.where(name: "Addition_3", number_of_problems: STANDARD_NO_PROBLEMS, steps: 3, timelimit: 900000, bonus: 40, icon: "challenges/Menu_Optellen.png").first_or_create

  division_challenge = BasicChallenge.where(name: "Division_1", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Delen.png").first_or_create
  two_division_challenge = BasicChallenge.where(name: "Division_2", number_of_problems: STANDARD_NO_PROBLEMS, steps: 2, timelimit: 900000, bonus: 30, icon: "challenges/Menu_Delen.png").first_or_create
  three_division_challenge = BasicChallenge.where(name: "Division_3", number_of_problems: STANDARD_NO_PROBLEMS, steps: 3, timelimit: 900000, bonus: 40, icon: "challenges/Menu_Delen.png").first_or_create

  multiplication_challenge = BasicChallenge.where(name: "Multiplication_1", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Vermenigvuldigen.png").first_or_create
  two_multiplication_challenge = BasicChallenge.where(name: "Multiplication_2", number_of_problems: STANDARD_NO_PROBLEMS, steps: 2, timelimit: 900000, bonus: 30, icon: "challenges/Menu_Vermenigvuldigen.png").first_or_create
  three_multiplication_challenge = BasicChallenge.where(name: "Multiplication_3", number_of_problems: STANDARD_NO_PROBLEMS, steps: 3, timelimit: 900000, bonus: 40, icon: "challenges/Menu_Vermenigvuldigen.png").first_or_create

  subtraction_challenge = BasicChallenge.where(name: "Subtraction_1", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Aftrekken.png").first_or_create
  two_subtraction_challenge = BasicChallenge.where(name: "Subtraction_2", number_of_problems: STANDARD_NO_PROBLEMS, steps: 2, timelimit: 900000, bonus: 30, icon: "challenges/Menu_Aftrekken.png").first_or_create
  three_subtraction_challenge = BasicChallenge.where(name: "Subtraction_3", number_of_problems: STANDARD_NO_PROBLEMS, steps: 3, timelimit: 900000, bonus: 40, icon: "challenges/Menu_Aftrekken.png").first_or_create

  mixed_challenge = BasicChallenge.where(name: "Mixed_1", number_of_problems: STANDARD_NO_PROBLEMS, steps:1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Mixed.png").first_or_create
  two_mixed_challenge = BasicChallenge.where(name: "Mixed_2", number_of_problems: STANDARD_NO_PROBLEMS, steps:2, timelimit: 900000, bonus: 30, icon: "challenges/Menu_Mixed.png").first_or_create
  three_mixed_challenge = BasicChallenge.where(name: "Mixed_3", number_of_problems: STANDARD_NO_PROBLEMS, steps:3, timelimit: 900000, bonus: 40, icon: "challenges/Menu_Mixed.png").first_or_create

  percentage_challenge = AdvancedChallenge.where(name: "PercentageAmountOfAmount", number_of_problems: STANDARD_NO_PROBLEMS, bonus: 20, icon: "challenges/Menu_PercentageA.png").first_or_create
  two_percentage_challenge = AdvancedChallenge.where(name: "PercentageOfUnit", number_of_problems: STANDARD_NO_PROBLEMS, bonus: 20, icon: "challenges/Menu_PercentageB.png").first_or_create
  three_percentage_challenge = AdvancedChallenge.where(name: "PercentageUnitToHundred", number_of_problems: STANDARD_NO_PROBLEMS, bonus: 20, icon: "challenges/Menu_PercentageC.png").first_or_create

  week1_challenge_set = ChallengeSet.where(name: "Week_1", locked: false).first_or_create
  week1_challenge_set.challenges << [addition_challenge, division_challenge, mixed_challenge, multiplication_challenge, subtraction_challenge, percentage_challenge,two_percentage_challenge, three_percentage_challenge]

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

  ChallengeSkill.where(skill: percentage, challenge: percentage_challenge).first_or_create
  ChallengeSkill.where(skill: percentage, challenge: two_percentage_challenge).first_or_create
  ChallengeSkill.where(skill: percentage, challenge: three_percentage_challenge).first_or_create
end
