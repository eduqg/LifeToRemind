FactoryBot.define do
  factory :mission, class: "Mission" do
    purpose_of_life { "asdadad" }
    who_am_i { "sadasdas" }
    why_exist { "asasddas" }
    association :user, factory: :user
  end
end