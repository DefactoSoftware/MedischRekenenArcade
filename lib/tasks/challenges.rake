task :create_challenges => :environment do
  STANDARD_NO_PROBLEMS = 10

  #WEEK 1
  week1_challenge_set = ChallengeSet.where(name: "Week_1", locked: false).first_or_create

  addition_challenge = Challenge.where(name: "Addition", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Optellen.png", challenge_set: week1_challenge_set).first_or_create
  division_challenge = Challenge.where(name: "Division", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Delen.png", challenge_set: week1_challenge_set).first_or_create
  multiplication_challenge = Challenge.where(name: "Multiplication", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Vermenigvuldigen.png", challenge_set: week1_challenge_set).first_or_create
  subtraction_challenge = Challenge.where(name: "Subtraction", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Aftrekken.png", challenge_set: week1_challenge_set).first_or_create
  mixed_challenge = Challenge.where(name: "Mixed", number_of_problems: STANDARD_NO_PROBLEMS, steps:1, timelimit: 900000, bonus: 20, icon: "challenges/Menu_Mixed.png", challenge_set: week1_challenge_set).first_or_create
  percentage_challenge = Challenge.where(name: "PercentageAmountOfAmount", number_of_problems: STANDARD_NO_PROBLEMS, bonus: 20, icon: "challenges/Menu_PercentageA.png", challenge_set: week1_challenge_set).first_or_create
  two_percentage_challenge = Challenge.where(name: "PercentageOfUnit", number_of_problems: STANDARD_NO_PROBLEMS, bonus: 20, icon: "challenges/Menu_PercentageB.png", challenge_set: week1_challenge_set).first_or_create
  three_percentage_challenge = Challenge.where(name: "PercentageUnitToHundred", number_of_problems: STANDARD_NO_PROBLEMS, bonus: 20, icon: "challenges/Menu_PercentageC.png", challenge_set: week1_challenge_set).first_or_create
  unit_conversion_challenge = Challenge.where(name: "UnitConversion", number_of_problems: STANDARD_NO_PROBLEMS, bonus: 20, icon: "challenges/Menu_UnitConversion.png", challenge_set: week1_challenge_set).first_or_create

  #WEEK 2
  week2_challenge_set = ChallengeSet.where(name: "Week_2", locked:false).first_or_create

  solution_maxisporin_challenge = Challenge.where(name: "SolutionMaxisporin", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 1500000, bonus: 20, icon: "challenges/SolutionA.png", challenge_set: week2_challenge_set).first_or_create
  concentration_tablet = Challenge.where(name: "ConcentrationTablet", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/ConcentrationA.png", challenge_set: week2_challenge_set).first_or_create
  concentration_to_hundred = Challenge.where(name: "ConcentrationToHundred", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/ConcentrationB.png", challenge_set: week2_challenge_set).first_or_create
  concentration_to_amount = Challenge.where(name: "ConcentrationAmount", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 900000, bonus: 20, icon: "challenges/ConcentrationC.png", challenge_set: week2_challenge_set).first_or_create

  #WEEK 3

  week3_challenge_set = ChallengeSet.where(name: "Week_3", locked:false).first_or_create

  syringe_pump_amount = Challenge.where(name: "SyringePumpAmount", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 1500000, bonus: 20, icon: "challenges/spuitpomp1.png", challenge_set: week3_challenge_set).first_or_create
  syringe_pump_hourly = Challenge.where(name: "SyringePumpHourly", number_of_problems: STANDARD_NO_PROBLEMS, steps: 1, timelimit: 1500000, bonus: 20, icon: "challenges/spuitpomp2.png", challenge_set: week3_challenge_set).first_or_create

end
