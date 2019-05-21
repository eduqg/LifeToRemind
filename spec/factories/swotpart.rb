FactoryBot.define do
  factory :swotpart, class: "Swotpart" do
    name { "Vontade" }
    partname { "strength" }
    association :plan, factory: :plan
  end
end