- user
  - name :string
  - email :string
  - password_digest :string

- task
  - title :string
  - content :text
  - deadline :datetime
  - priority :integer
  - status :integer
  - user_id :integer

- label
  - label_name :string

- task_label
  - task_id :integer
  - label_id :integer
