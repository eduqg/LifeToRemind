FactoryBot.define do
  factory :objective, class: "Objective" do
    name { "Conseguir uma promoção" }
    association :plan, factory: :plan
    association :sphere, factory: :sphere
  end
end