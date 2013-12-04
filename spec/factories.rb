FactoryGirl.define do
  factory :step do

  end

  factory :friendship do
    friend_id { FactoryGirl.create(:user).id }
  end

  factory :skill do
    name { Faker::HipsterIpsum.word }
  end

  factory :user_group do
    name { Faker::HipsterIpsum.word }
  end


  factory :user do
    confirmed_at { DateTime.now }
    name { Faker::HipsterIpsum.name }
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password "welkom1234"
    user_group
  end
end
