FactoryBot.define do
  factory :plan, class: "Plan" do
    life_objective { Faker::Hipster.sentence(10) }
    association :user, factory: :user
  end
end