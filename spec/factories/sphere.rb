FactoryBot.define do
  factory :sphere, class: "Sphere" do
    name { Faker::Lorem.characters(30)  }
    association :user, factory: :user
  end
end