FactoryBot.define do
  factory :plan, class: "Plan" do
    name { Faker::Lorem.characters(30)  }
    association :user, factory: :user
  end
end