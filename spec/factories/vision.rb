FactoryBot.define do
  factory :vision, class: "Vision" do
    where_im_going { "asdadad" }
    where_arrive { "sadasdas" }
    how_complete_mission { "asasddas" }
    association :user, factory: :user
  end
end