FactoryBot.define do
  factory :value, class: "Value" do
    name { "Resistencia" }
    association :plan, factory: :plan
  end
end