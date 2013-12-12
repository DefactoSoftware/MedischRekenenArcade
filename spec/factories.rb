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

  factory :problem do

  end

  factory :user do
    confirmed_at { DateTime.now }
    name { Faker::HipsterIpsum.name }
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password "welkom1234"
    user_group
  end

  factory :answer do
    value { 1 }
    problem
  end

  factory :challenge do
    number_of_problems { 5 }
    name { Faker::HipsterIpsum.word }
    timelimit { 9000000 }
    bonus { 20 }
    icon { "google.com/images/srpr/logo11w.png" }
  end

  factory :user_challenge do
    user
    challenge
    amount_good { 0 }
    amount_fail { 0 }
  end

  factory :challenge_skill do
    challenge
    skill
  end
end
