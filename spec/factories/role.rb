FactoryBot.define do
  factory :role, class: "Role" do
    name { "Filho" }
    description { "Melhorar como filho" }
    association :plan, factory: :plan
  end
end