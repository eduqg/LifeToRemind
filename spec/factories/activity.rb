FactoryBot.define do
  factory :activity, class: "Activity" do
    title { "Conseguir 1000 reais" }
    association :goal, factory: :goal
  end
end