FactoryBot.define do
  factory :user do
    email { "bot@bot.com" }
    name { "bot" }
    password { "123456" }
  end
end
