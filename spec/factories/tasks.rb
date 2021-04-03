require "date"
FactoryBot.define do
  factory :first_task, class: Task do
    title { 'test_title1' }
    content { 'test_content1' }
    expired_at { DateTime.new(2021,4,1) }
    status { 1 }
    priority { 2 }

    association :user
  end

  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    expired_at { DateTime.new(2021,6,1)}
    status { 2 }
    priority { 3 }

    association :user
  end

  factory :third_task, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
    expired_at { DateTime.new(2021,5,1) }
    status { 3 }
    priority { 1 }

    association :user
  end
end
