task :create_units => :environment do
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
end