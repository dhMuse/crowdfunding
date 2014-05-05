FactoryGirl.define do
  factory :reward_level do
    association :campaign, factory: :campaign
    title Faker::Company.bs
    details Faker::Lorem.paragraph
    amount 1000000
  end

end
