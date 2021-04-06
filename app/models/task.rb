class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true

  enum status: {
    未着手:1,着手中:2,完了:3
  }

  enum priority: {
    高:1, 中:2, 低:3
  }

  scope :search_title, -> (data){ where('title Like ?', "%#{data}%") }
  scope :search_status, -> (data){ where(status: data) }
  scope :search_tag, -> (data){ joins(:tags).where('tags.id = ?', data)}

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
end
