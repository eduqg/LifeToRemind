FactoryBot.define do
  factory :goal, class: "Goal" do
    name { "Conseguir um milhão de reais" }
    association :objective, factory: :objective
  end
end