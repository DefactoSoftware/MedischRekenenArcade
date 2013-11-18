FactoryGirl.define do
  factory :step do

  end

  factory :skill do
    name { Faker::HipsterIpsum.word }
  end

  factory :variable do
    key { Faker::HipsterIpsum.word }
    value { rand(1...10) }
  end
end
