FactoryBot.define do
  factory :admin_user,class: User do
    name { "admin" }
    email { "admin@test.com" }
    password { "password" }
    admin { true }
  end
end
