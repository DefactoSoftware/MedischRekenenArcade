FactoryGirl.define do
  factory :step do

  end

  factory :skill do
    name { Faker::HipsterIpsum.word }
  end
end
