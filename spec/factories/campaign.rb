FactoryGirl.define do
  factory :campaign do
    association :user, factory: :user
    after :build do |camp|
      camp.reward_levels << FactoryGirl.create(:reward_level, campaign: camp)
    end
    title Faker::Company.bs
    details Faker::Lorem.paragraph
    target 1000000
    end_date (Time.now + 28.days)
  end

end
