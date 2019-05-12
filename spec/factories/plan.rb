FactoryBot.define do
  factory :plan, class: "Plan" do
    name { Faker::Hipster.sentence(10) }
    association :user, factory: :user
  end
end