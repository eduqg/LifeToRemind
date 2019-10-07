FactoryBot.define do
  factory :sphere, class: "Sphere" do
    name { Faker::Lorem.characters(number: 30)  }
    association :user, factory: :user
  end
end