FactoryBot.define do
  factory :plan, class: "Plan" do
    name { Faker::Lorem.characters(number: 30)  }
    association :user, factory: :user
  end
end