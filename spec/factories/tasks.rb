FactoryBot.define do
  factory :task do
    title { 'test_title1' }
    content { 'test_content1' }
  end

  factory :second_task,class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
  end

  factory :third_task, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
  end
end
