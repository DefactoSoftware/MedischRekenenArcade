# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

grams = UnitGroup.where(name: "grams").first_or_create
liters = UnitGroup.where(name: "liters").first_or_create
drops = UnitGroup.where(name: "drop").first_or_create

Unit.where(name: "Milliter", sign: "ml", unit_group: liters).first_or_create
Unit.where(name: "Centiliter", sign: "cl", unit_group: liters).first_or_create
Unit.where(name: "Deciliter", sign: "dl", unit_group: liters).first_or_create
Unit.where(name: "Liter", sign: "l", unit_group: liters).first_or_create
Unit.where(name: "Drops", sign: "dr", unit_group: drops).first_or_create
Unit.where(name: "Milligram", sign: "mg", unit_group: grams).first_or_create
Unit.where(name: "Centigram", sign: "cg", unit_group: grams).first_or_create
Unit.where(name: "Decigram", sign: "dg", unit_group: grams).first_or_create
Unit.where(name: "Gram", sign: "g", unit_group: grams).first_or_create


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

group = UserGroup.where(name: "NHL").first_or_create
User.where(name: "Marthyn Olthof", username:"Marthyn", password:"Welkom1234", email:"Marthyn@live.nl", confirmed_at: DateTime.now, user_group: group).create

