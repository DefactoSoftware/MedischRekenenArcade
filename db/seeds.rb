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

User.where(name: "Marthyn Olthof", username:"Marthyn", password:"Welkom1234", email:"Marthyn@live.nl", confirmed_at: DateTime.now).create
