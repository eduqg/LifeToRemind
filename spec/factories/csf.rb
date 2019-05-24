FactoryBot.define do
  factory :csf, class: "Csf" do
    what_makes_me_unique { "asdasdsdad" }
    best_attributes { "sasdsddasdas" }
    essential_atributes { "asasdsdsddas" }
    health_factors { "asasddadsddss" }
    association :user, factory: :user
  end
end