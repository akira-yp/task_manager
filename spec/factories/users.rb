FactoryBot.define do
  factory :admin_user,class: User do
    name { "admin" }
    email { "admin@test.com" }
    password { "password" }
    admin { true }
  end

  factory :first_user,class: User do
    name { "first_user" }
    email { "first_user@test.com" }
    password { "password" }
    admin { false }
  end

  factory :second_user,class: User do
    name { "second_user" }
    email { "second_user@test.com" }
    password { "password" }
    admin { false }
  end
end
