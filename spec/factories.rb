FactoryGirl.define do
  factory :step do

  end

  factory :friendship do
    friend_id { create(:user).id }
  end

  factory :skill do
    name { Faker::HipsterIpsum.word }
  end

  factory :unit do
    sign { "ml" }
  end

  factory :user_skill do
    skill
    user
    level { rand(0..10) }
  end

  factory :user_group do
    name { Faker::HipsterIpsum.word }
  end

  factory :problem do

  end

  factory :subtraction do

  end

  factory :oxygen_time do
    unit
  end

  factory :head_to_head_challenge do
    association :challenger, factory: :user
    association :challenged, factory: :user
    challenge
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

  factory :challenge_set do
    name { Faker::HipsterIpsum.name }
    locked { false }

    factory :challenge_set_with_challenges do
      after(:create) do |challenge_set|
        create_list(:challenge, 2, challenge_set: challenge_set)
      end
    end
  end

  factory :challenge do
    number_of_problems { 5 }
    sequence(:name) do |n|
      Challenge::VALID_NAMES[n]
    end
    timelimit { 9000000 }
    bonus { 20 }
    icon { "google.com/images/srpr/logo11w.png" }
    challenge_set
  end

  factory :user_challenge do
    user
    challenge
    amount_good { 0 }
    amount_fail { 0 }
  end

  factory :feedback_report do
    user
    text { Faker::HipsterIpsum.paragraph }
    subject { Faker::HipsterIpsum.word }
    page { Faker::HipsterIpsum.word }
  end
end
