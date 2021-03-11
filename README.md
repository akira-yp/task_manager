- user
  - user_name :string
  - email :string
  - password_digest :string

- task
  - task_name :stgrings
  - task_content :text
  - deadline :datetime
  - priority :integer
  - status :integer
  - user_id :integer

- label
  - label_name :string

- task_label
  - task_id :integer
  - label_id :integer
