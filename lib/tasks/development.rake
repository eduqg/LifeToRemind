namespace :development do
  task create_test_user: :environment do
    raise 'Can only be run on development!' unless Rails.env.development?

    User.create!(name: 'user',
                 email: 'user@example.com',
                 password: 'testing123')
  end
end
