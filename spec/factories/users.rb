FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::FunnyName.three_word_name }
    password { "abc34ERT1!!@@" }
  end
end
