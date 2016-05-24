desc "utility functions to support development"

namespace :development_utils do
  task reload: [:environment] do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["development_utils:make_users"].invoke
  end

  task make_users: [:environment] do
    test_01 = User.create email: 'test_01@test.com', password: 'secret', password_confirmation: 'secret'
    test_02 = User.create email: 'test_02@test.com', password: 'secret', password_confirmation: 'secret'

    directory = Directory.create user: test_02

    ['malcolm', 'kaylee', 'wash', 'jayne'].each do |name|
      Contact.create directory: directory,
                     name: name,
                     phone: "(#{(rand(9) + 1).to_s * 3}) #{(rand(9) + 1).to_s * 3} - " \
                            "#{(rand(9) + 1).to_s * 4}",
                     email: "#{name}@serenity.com"

    end
  end
end